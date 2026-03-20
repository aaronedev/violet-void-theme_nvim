local M = {}

---@type violet-void.HighlightsFn
function M.get(c)
  return {
    -- oil.nvim
    ["OilBorder"] = "FloatBorder",
    ["OilDir"] = "Directory",
    ["OilDirIcon"] = "Directory",
    ["OilFile"] = "Normal",
    ["OilFileIcon"] = "Normal",
    ["OilHelp"] = "Title",
    ["OilHead"] = "Title",
    ["OilLink"] = "Underlined",
    ["OilLinkTarget"] = "Underlined",
    ["OilMutable"] = "Special",
    ["OilNormal"] = "Normal",
    ["OilPreview"] = "Normal",
    ["OilSelect"] = "Visual",
  }
end

return M
