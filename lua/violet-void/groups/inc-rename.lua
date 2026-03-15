local M = {}

M.url = "https://github.com/smjonas/inc-rename.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    IncRename = { fg = c.magenta, bold = true },
    IncRenameMatch = { link = "Substitute" },
  }
end

return M
