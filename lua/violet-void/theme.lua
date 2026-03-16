local M = {}

---@param opts? VioletVoid.Config
function M.setup(opts)
  opts = require("violet-void.config").extend(opts)
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
    colors = require("violet-void.colors").setup(opts)
    groups = require("violet-void.groups").setup(colors, opts)
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

  for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end

  if opts.terminal_colors then
    M.terminal(colors)
  end

  -- Apply filetype-specific highlight overrides
  M.filetypes(opts.filetypes)

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
