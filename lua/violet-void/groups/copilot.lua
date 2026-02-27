local Util = require("violet-void.util")

local M = {}

M.url = "https://github.com/zbirenbaum/copilot.lua"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local ret = {
    CopilotAnnotation = { fg = Util.blend_fg(c.comment, 0.8), bg = c.terminal_black },
    CopilotSuggestion = { fg = Util.blend_fg(c.comment, 0.8), bg = c.terminal_black },
  }
  return ret
end

return M
