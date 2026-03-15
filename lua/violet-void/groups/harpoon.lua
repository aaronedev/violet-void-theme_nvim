local M = {}

M.url = "https://github.com/ThePrimeagen/harpoon"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    HarpoonBorder        = { fg = c.border_highlight, bg = c.bg_float },
    HarpoonWindow        = { fg = c.fg, bg = c.bg_float },
    HarpoonWindowActive  = { fg = c.fg, bg = c.bg_highlight },
    HarpoonMarker        = { fg = c.purple },
    HarpoonMarkerCurrent = { fg = c.magenta, bold = true },
    HarpoonMarkerVisited = { fg = c.teal },
  }
end

return M
