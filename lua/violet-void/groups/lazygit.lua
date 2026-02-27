local M = {}

M.url = "https://github.com/kdheepak/lazygit.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LazyGitFloat  = { fg = c.fg, bg = c.bg_float },
    LazyGitBorder = { fg = c.border_highlight, bg = c.bg_float },
  }
end

return M
