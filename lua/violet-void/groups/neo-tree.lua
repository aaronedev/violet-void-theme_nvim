local Util = require("violet-void.util")

local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

---@type violet-void.HighlightsFn
function M.get(c, opts)
  local dark = opts.styles.sidebars == "transparent" and c.none
    or Util.blend(c.bg_sidebar, 0.9, opts.style == "day" and c.yellow or "#000000")

  -- stylua: ignore
  return {
    NeoTreeDimText             = { fg = Util.blend_fg(c.fg_gutter, 0.9)},
    NeoTreeFileName            = { fg = Util.blend_fg(c.fg_gutter, 0.9)},
    NeoTreeDirectoryName       = { fg = Util.blend_fg(c.fg_gutter, 0.9) },
    NeoTreeDirectoryIcon       = { fg = c.magenta },
    NeoTreeRootName            = { fg = c.magenta, bold = true },
    NeoTreeStatusLine          = { fg = Util.blend_fg(c.fg_gutter, 0.9), bg = c.bg_sidebar },
    NeoTreeStatusLineNC        = { fg = c.fg_gutter, bg = c.bg_sidebar },
    NeoTreeGitModified         = { fg = c.orange },
    NeoTreeGitStaged           = { fg = c.green1 },
    NeoTreeGitUntracked        = { fg = c.magenta },
    NeoTreeNormal              = { fg = Util.blend_fg(c.fg_gutter, 0.9), bg = c.bg_sidebar },
    NeoTreeNormalNC            = { fg = Util.blend_fg(c.fg_gutter, 0.9), bg = c.bg_sidebar },
    NeoTreeTabActive           = { fg = c.magenta, bg = c.bg_dark, bold = true },
    NeoTreeTabInactive         = { fg = c.dark3, bg = dark },
    NeoTreeTabSeparatorActive  = { fg = c.magenta, bg = c.bg_dark },
    NeoTreeTabSeparatorInactive= { fg = c.bg, bg = dark },
  }
end

return M
