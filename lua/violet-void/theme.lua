local M = {}

-- Profiling data (available when profiling is enabled)
M.profile = {
  enabled = false,
  timings = {},
}

local function profiling_enabled()
  return M.profile.enabled
end

local function profile_start(label)
  if profiling_enabled() then
    M.profile.timings[label] = { start = vim.loop.hrtime() }
  end
end

local function profile_end(label)
  if profiling_enabled() and M.profile.timings[label] then
    M.profile.timings[label].end_ = vim.loop.hrtime()
    M.profile.timings[label].duration =
      (M.profile.timings[label].end_ - M.profile.timings[label].start) / 1e6
  end
end

--- Get profiling results
---@return table
function M.get_profile()
  return M.profile.timings
end

--- Enable or disable profiling
---@param enabled boolean
function M.set_profile(enabled)
  M.profile.enabled = enabled
  if not enabled then
    M.profile.timings = {}
  end
end

--- Apply highlights in optimized batches
---@param groups table<string, table>
---@param batch_size number number of highlights per batch
local function apply_highlights(groups, batch_size)
  batch_size = batch_size or 50

  -- Pre-process links to avoid circular references
  local links = {}
  local direct = {}

  for group, hl in pairs(groups) do
    if type(hl) == "string" then
      links[group] = hl
    else
      direct[group] = hl
    end
  end

  -- Apply direct highlights in batches
  local batch = {}
  local count = 0

  for group, hl in pairs(direct) do
    table.insert(batch, { group = group, hl = hl })
    count = count + 1

    if count >= batch_size then
      for _, item in ipairs(batch) do
        vim.api.nvim_set_hl(0, item.group, item.hl)
      end
      batch = {}
      count = 0
    end
  end

  -- Apply remaining
  if count > 0 then
    for _, item in ipairs(batch) do
      vim.api.nvim_set_hl(0, item.group, item.hl)
    end
  end

  -- Apply links (they're simple and fast)
  for group, link in pairs(links) do
    vim.api.nvim_set_hl(0, group, { link = link })
  end
end

---@param opts? VioletVoid.Config
function M.setup(opts)
  profile_start("total")
  opts = require("violet-void.config").extend(opts)

  -- Handle high_contrast option - override style to high-contrast variant
  if opts.high_contrast then
    opts.style = "violet-void-high-contrast"
  end

  local Util = require("violet-void.util")

  -- Handle stale cache during development/hot-reload
  if not Util.cache or not Util.cache.read then
    package.loaded["violet-void.util"] = nil
    Util = require("violet-void.util")
  end

  local cache_key = opts.style or "violet-void"
  local cache = opts.cache and Util.cache.read(cache_key)

  local colors, groups
  if cache then
    colors = cache.colors
    groups = cache.groups
  else
    profile_start("colors_setup")
    colors = require("violet-void.colors").setup(opts)
    profile_end("colors_setup")

    profile_start("groups_setup")
    groups = require("violet-void.groups").setup(colors, opts)
    profile_end("groups_setup")

    if opts.cache then
      Util.cache.write(cache_key, { colors = colors, groups = groups })
    end
  end

  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = opts.style or "violet-void"

  -- Apply highlights using optimized batched approach
  profile_start("highlight_application")
  apply_highlights(groups)
  profile_end("highlight_application")

  if opts.terminal_colors then
    profile_start("terminal_colors")
    M.terminal(colors)
    profile_end("terminal_colors")
  end

  -- Apply filetype-specific highlight overrides
  M.filetypes(opts.filetypes)

  -- Set up lazy loading for plugin highlights
  M.lazy_load(colors, opts)

  profile_end("total")

  return colors, groups, opts
end

--- Apply filetype-specific highlight overrides
---@param filetypes table<string, table<string, any>>
function M.filetypes(filetypes)
  if not filetypes then
    return
  end

  -- Function to apply filetype highlights
  local apply = function()
    local buf_ft = vim.bo.filetype
    local ft_overrides = filetypes[buf_ft]
    if not ft_overrides then
      return
    end

    for group, hl in pairs(ft_overrides) do
      hl = type(hl) == "string" and { link = hl } or hl
      vim.api.nvim_set_hl(0, group, hl)
    end
  end

  -- Apply for current buffer
  apply()

  -- Set up autocmd to apply when filetype changes
  local group = vim.api.nvim_create_augroup("VioletVoidFiletypes", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = apply,
  })
end

--- Set up lazy loading for plugin highlights
--- When enabled, plugin highlights are only applied when the plugin is first loaded
---@param colors ColorScheme
---@param opts VioletVoid.Config
function M.lazy_load(colors, opts)
  if not opts.plugins.lazy_load then
    return
  end

  -- Only works with lazy.nvim
  if not package.loaded.lazy then
    vim.notify("lazy_load requires lazy.nvim", vim.log.levels.WARN)
    return
  end

  local groups = require("violet-void.groups")
  local lazy_plugins = require("lazy.core.config").plugins

  -- Find plugins that aren't loaded yet
  local pending = {}
  for plugin, group_name in pairs(groups.plugins) do
    if not lazy_plugins[plugin] then
      goto continue
    end

    -- Check if plugin is loaded
    local spec = lazy_plugins[plugin]
    if not spec._loaded then
      pending[plugin] = group_name
    end

    ::continue::
  end

  if vim.tbl_isempty(pending) then
    return
  end

  -- Create autocmd group
  local lazy_group = vim.api.nvim_create_augroup("VioletVoidLazyLoad", { clear = true })

  -- Function to apply highlights for a plugin
  local apply_plugin = function(plugin_name, group_name)
    local plugin_groups = groups.get(group_name, colors, opts)
    if vim.tbl_isempty(plugin_groups) then
      return
    end

    for hl_name, hl_def in pairs(plugin_groups) do
      vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
  end

  -- Set up LazyLoad autocmd for each pending plugin
  vim.api.nvim_create_autocmd("LazyLoad", {
    group = lazy_group,
    callback = function(args)
      local plugin_name = args.file
      local group_name = pending[plugin_name]
      if group_name then
        apply_plugin(plugin_name, group_name)
        pending[plugin_name] = nil

        -- Clean up if all plugins are loaded
        if vim.tbl_isempty(pending) then
          vim.api.nvim_del_augroup_by_id(lazy_group)
        end
      end
    end,
  })
end

---@param colors ColorScheme
function M.terminal(colors)
  -- dark
  vim.g.terminal_color_0 = colors.terminal.black
  vim.g.terminal_color_8 = colors.terminal.black_bright

  -- light
  vim.g.terminal_color_7 = colors.terminal.white
  vim.g.terminal_color_15 = colors.terminal.white_bright

  -- colors
  vim.g.terminal_color_1 = colors.terminal.red
  vim.g.terminal_color_9 = colors.terminal.red_bright

  vim.g.terminal_color_2 = colors.terminal.green
  vim.g.terminal_color_10 = colors.terminal.green_bright

  vim.g.terminal_color_3 = colors.terminal.yellow
  vim.g.terminal_color_11 = colors.terminal.yellow_bright

  vim.g.terminal_color_4 = colors.terminal.blue
  vim.g.terminal_color_12 = colors.terminal.blue_bright

  vim.g.terminal_color_5 = colors.terminal.magenta
  vim.g.terminal_color_13 = colors.terminal.magenta_bright

  vim.g.terminal_color_6 = colors.terminal.cyan
  vim.g.terminal_color_14 = colors.terminal.cyan_bright
end

return M
