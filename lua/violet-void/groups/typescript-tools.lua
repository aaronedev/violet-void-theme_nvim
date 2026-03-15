local M = {}

M.url = "https://github.com/pmizio/typescript-tools.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    TSType              = { fg = c.purple },
    TSTypeBuiltin      = { fg = c.purple1 },
    TSProperty         = { fg = c.blue1 },
    TSMethod           = { fg = c.cyan },
    TSFunction         = { fg = c.cyan },
    TSFuncBuiltin      = { fg = c.cyan },
    TSConstant         = { fg = c.orange },
    TSString           = { fg = c.green },
    TSStringSpecial    = { fg = c.green1 },
    TSNumber           = { fg = c.orange },
    TSBoolean          = { fg = c.orange },
    TSOperator         = { fg = c.red1 },
    TSPunctBracket     = { fg = c.fg },
    TSPunctDelimiter   = { fg = c.fg_dim },
    TSKeyword          = { fg = c.magenta },
    TSKeywordFunction  = { fg = c.magenta },
    TSKeywordOperator  = { fg = c.red1 },
    TSKeywordReturn    = { fg = c.magenta },
    TSComment          = { fg = c.comment },
    TSNote             = { fg = c.green },
    TSWarning          = { fg = c.yellow },
    TSDanger           = { fg = c.red },
    TSLabel            = { fg = c.blue1 },
    TSStructure        = { fg = c.magenta },
    TSField            = { fg = c.blue1 },
    TSParameter        = { fg = c.orange },
    TSParameterReference = { fg = c.orange },
    TSDefinition       = { fg = c.cyan, underline = true },
    TSDefinitionReadOnly = { fg = c.cyan, underline = true, sp = c.purple },
  }
end

return M
