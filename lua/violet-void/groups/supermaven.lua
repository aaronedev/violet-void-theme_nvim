local M = {}

M.url = "https://github.com/supermaven-inc/supermaven-nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local ret = {
    SupermavenSuggestion = { fg = c.terminal_black },
  }
  return ret
end

return M
