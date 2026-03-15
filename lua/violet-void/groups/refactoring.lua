local M = {}

M.url = "https://github.com/ThePrimeagen/refactoring.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    RefactoringHeader    = { fg = c.purple, bold = true },
    RefactoringPrompt   = { fg = c.fg },
    RefactoringPreview  = { fg = c.purple },
    RefactoringHelp     = { fg = c.comment },
    RefactoringConfirm  = { fg = c.green, bold = true },
    RefactoringCancel   = { fg = c.red, bold = true },
  }
end

return M
