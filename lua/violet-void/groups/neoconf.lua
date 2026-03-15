local M = {}

M.url = "https://github.com/folke/neoconf.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    NeoconfBorder        = { fg = c.border_highlight, bg = c.bg_float },
    NeoconfEmpty          = { fg = c.comment },
    NeoconfFloat         = { fg = c.fg, bg = c.bg_float },
    NeoconfHeader        = { fg = c.purple, bold = true },
    NeoconfKey           = { fg = c.blue },
    NeoconfLoading       = { fg = c.comment, italic = true },
    NeoconfMatch         = { fg = c.purple, bold = true },
    NeoconfPath          = { fg = c.teal },
    NeoconfSchemaError   = { fg = c.red, bold = true },
    NeoconfSchemaInfo    = { fg = c.info },
    NeoconfSchemaKey     = { fg = c.blue },
    NeoconfSchemaType   = { fg = c.magenta },
    NeoconfSelection     = { bg = c.bg_visual },
    NeoconfSelectionLine = { bg = c.bg_highlight },
    NeoconfValue         = { fg = c.green },
  }
end

return M
