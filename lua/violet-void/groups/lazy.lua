local M = {}

M.url = "https://github.com/folke/lazy.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LazyProgressDone = { bold = true, fg = c.green2},
    LazyProgressTodo = { bold = true, fg = c.magenta2},
  }
end

return M
