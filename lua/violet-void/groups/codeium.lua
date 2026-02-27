local Util = require("violet-void.util")

local M = {}

M.url = "https://github.com/Exafunction/codeium.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local ret = {
    CodeiumSuggestion = { fg = Util.blend_fg(c.comment, 0.8), style = { italic = true } },
  }
  return ret
end

return M
