local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    WhichKey          = { fg = c.cyan },
    WhichKeyGroup     = { fg = c.blue0 },
    WhichKeyDesc      = { fg = c.magenta },
    WhichKeySeparator = { fg = c.purple },
    WhichKeyNormal    = { fg = c.fg, bg = c.bg_sidebar },
    WhichKeyValue     = { fg = c.blue2 },
    WhichKeyBorder    = { fg = c.border_highlight, bg = c.bg_float},
  }
end

return M
