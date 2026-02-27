local Util = require("violet-void.util")

local M = {}

M.url = "https://github.com/RRethy/vim-illuminate"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    IlluminatedWordRead  = { bg = Util.blend_bg(c.teal, 0.2), fg = Util.blend_fg(c.teal, 0.8) },
    IlluminatedWordText  = { bg = Util.blend_bg(c.teal, 0.1), fg = Util.blend_fg(c.teal, 0.69) },
    IlluminatedWordWrite = { bg = Util.blend_bg(c.teal, 0.33)},
    illuminatedCurWord   = { bg = Util.blend_bg(c.teal, 0.77)},
    illuminatedWord      = { bg = Util.blend_bg(c.teal, 0.33)},
  }
end

return M
