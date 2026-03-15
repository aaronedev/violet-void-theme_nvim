local M = {}

M.url = "https://github.com/akinsho/toggleterm.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    ToggleTerm = { fg = c.blue },
    ToggleTermBorder = { fg = c.border },
    ToggleTermSign = { fg = c.blue },
    ToggleTermCursorLine = { bg = c.bg_highlight },
  }
end

return M