local M = {}

M.url = "https://github.com/ray-x/go.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    GoTest              = { fg = c.green },
    GoTestFail         = { fg = c.red },
    GoBench             = { fg = c.blue },
    GoConyardTest      = { fg = c.green },
    GoCoverageDrop     = { fg = c.red },
    GoCoveragePass     = { fg = c.green },
    GoErr              = { fg = c.red },
    GoFunction         = { fg = c.cyan },
    GoMethod           = { fg = c.cyan },
    GoStruct           = { fg = c.blue1 },
    GoType             = { fg = c.purple },
    GoTypeSpec         = { fg = c.purple },
    GoVar              = { fg = c.orange },
    GoParamType        = { fg = c.yellow },
    GoReturns          = { fg = c.magenta },
    GoPackage          = { fg = c.blue1 },
    GoImport           = { fg = c.blue1 },
    GoFunctionCall     = { fg = c.cyan },
    GoMethodCall       = { fg = c.cyan },
    GoField            = { fg = c.blue1 },
    GoKey              = { fg = c.orange },
    GoValue            = { fg = c.green },
    GoLiteral          = { fg = c.green },
    GoTrue             = { fg = c.green },
    GoFalse            = { fg = c.red },
    GoNil              = { fg = c.magenta },
  }
end

return M
