local Util = require("violet-void.util")

local M = {}

-- stylua: ignore
M.plugins = {
  ["aerial.nvim"]                   = "aerial",
  ["ale"]                           = "ale",
  ["alpha-nvim"]                    = "alpha",
  ["barbar.nvim"]                   = "barbar",
  ["blink.cmp"]                     = "blink",
  ["bufferline.nvim"]               = "bufferline",
  ["codeium.nvim"]                  = "codeium",
  ["copilot.lua"]                   = "copilot",
  ["dashboard-nvim"]                = "dashboard",
  ["neowarrior.nvim"]               = "neowarrior",
  ["flash.nvim"]                    = "flash",
  ["fzf-lua"]                       = "fzf",
  ["gitsigns.nvim"]                 = "gitsigns",
  ["grug-far.nvim"]                 = "grug-far",
  ["harpoon"]                       = "harpoon",
  ["headlines.nvim"]                = "headlines",
  ["hop.nvim"]                      = "hop",
  ["indent-blankline.nvim"]         = "indent-blankline",
  ["indentmini.nvim"]               = "indentmini",
  ["inc-rename.nvim"]               = "inc-rename",
  ["lazy.nvim"]                     = "lazy",
  ["lazygit.nvim"]                  = "lazygit",
  ["leap.nvim"]                     = "leap",
  ["lspsaga.nvim"]                  = "lspsaga",
  ["mini.animate"]                  = "mini_animate",
  ["mini.clue"]                     = "mini_clue",
  ["mini.completion"]               = "mini_completion",
  ["mini.cursorword"]               = "mini_cursorword",
  ["mini.deps"]                     = "mini_deps",
  ["mini.diff"]                     = "mini_diff",
  ["mini.files"]                    = "mini_files",
  ["mini.hipatterns"]               = "mini_hipatterns",
  ["mini.icons"]                    = "mini_icons",
  ["mini.indentscope"]              = "mini_indentscope",
  ["mini.jump"]                     = "mini_jump",
  ["mini.map"]                      = "mini_map",
  ["mini.notify"]                   = "mini_notify",
  ["mini.operators"]                = "mini_operators",
  ["mini.pick"]                     = "mini_pick",
  ["mini.starter"]                  = "mini_starter",
  ["mini.statusline"]               = "mini_statusline",
  ["mini.surround"]                 = "mini_surround",
  ["mini.tabline"]                  = "mini_tabline",
  ["mini.test"]                     = "mini_test",
  ["mini.trailspace"]               = "mini_trailspace",
  ["neo-tree.nvim"]                 = "neo-tree",
  ["neoconf.nvim"]                  = "neoconf",
  ["neogit"]                        = "neogit",
  ["neotest"]                       = "neotest",
  ["noice.nvim"]                    = "noice",
  ["nvim-cmp"]                      = "cmp",
  ["nvim-dap"]                      = "dap",
  ["nvim-navic"]                    = "navic",
  ["nvim-notify"]                   = "notify",
  ["nvim-scrollbar"]                = "scrollbar",
  ["nvim-tree.lua"]                 = "nvim-tree",
  ["nvim-treesitter-context"]       = "treesitter-context",
  ["octo.nvim"]                     = "octo",
  ["rainbow-delimiters.nvim"]       = "rainbow",
  ["refactoring.nvim"]               = "refactoring",
  ["render-markdown.nvim"]          = "render-markdown",
  ["snacks.nvim"]                   = "snacks",
  ["spectre.nvim"]                  = "spectre",
  ["supermaven-nvim"]               = "supermaven",
  ["telescope-file-browser.nvim"] = "telescope-file-browser",
  ["telescope.nvim"]                = "telescope",
  ["trouble.nvim"]                  = "trouble",
  ["vim-gitgutter"]                 = "gitgutter",
  ["vim-glyph-palette"]             = "glyph-palette",
  ["vim-illuminate"]                = "illuminate",
  ["vim-sneak"]                     = "sneak",
  ["vimwiki"]                       = "vimwiki",
  ["which-key.nvim"]                = "which-key",
  ["yanky.nvim"]                    = "yanky"
}

local me = debug.getinfo(1, "S").source:sub(2)
me = vim.fn.fnamemodify(me, ":h")

function M.get_group(name)
  ---@type {get: violet-void.HighlightsFn, url: string}
  local ok, mod = pcall(require, "violet-void.groups." .. name)
  if not ok then
    return {
      get = function()
        return {}
      end,
    }
  end
  return mod
end

---@param colors ColorScheme
---@param opts VioletVoid.Config
function M.get(name, colors, opts)
  local mod = M.get_group(name)
  return mod.get(colors, opts)
end

---@param colors ColorScheme
---@param opts VioletVoid.Config
function M.setup(colors, opts)
  local groups = {
    base = true,
    kinds = true,
    semantic_tokens = true,
    treesitter = true,
  }

  if opts.plugins.all then
    for _, group in pairs(M.plugins) do
      groups[group] = true
    end
  elseif opts.plugins.auto and package.loaded.lazy then
    local plugins = require("lazy.core.config").plugins
    for plugin, group in pairs(M.plugins) do
      if plugins[plugin] then
        groups[group] = true
      end
    end

    -- special case for mini.nvim
    if plugins["mini.nvim"] then
      for _, group in pairs(M.plugins) do
        if group:find("^mini_") then
          groups[group] = true
        end
      end
    end
  end

  -- manually enable/disable plugins
  for plugin, group in pairs(M.plugins) do
    local use = opts.plugins[group]
    use = use == nil and opts.plugins[plugin] or use
    if use ~= nil then
      if type(use) == "table" then
        use = use.enabled
      end
      groups[group] = use or nil
    end
  end

  local names = vim.tbl_keys(groups)
  table.sort(names)

  local ret = {}
  -- merge highlights
  for group in pairs(groups) do
    for k, v in pairs(M.get(group, colors, opts)) do
      ret[k] = v
    end
  end
  Util.resolve(ret)

  opts.on_highlights(ret, colors)

  return ret, groups
end

return M
