local M = {}

M.url = "https://github.com/nvim-pack/nvim-spectre"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    SpectreBorder       = { fg = c.border_highlight, bg = c.bg_float },
    SpectreNormal       = { fg = c.fg, bg = c.bg_float },
    SpectreHeader       = { fg = c.purple },
    SpectreSearch       = { fg = c.fg, bg = c.bg_highlight },
    SpectreReplace      = { fg = c.red, bg = c.bg_highlight },
    SpectreFile         = { fg = c.cyan },
    SpectreMatch        = { fg = c.magenta, bold = true },
    SpectrePrompt       = { fg = c.fg, bg = c.bg_float },
    SpectreCursorLine   = { bg = c.bg_highlight },
    SpectreSelection    = { bg = c.bg_highlight },
    SpectreSeparator    = { fg = c.dark3 },
    SpectreFolder       = { fg = c.blue0 },
    SpectreWord         = { fg = c.orange, underline = true },
  }
end

return M
