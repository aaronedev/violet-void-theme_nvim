local M = {}

---@type violet-void.HighlightsFn
function M.get(c)
  return {
    -- LSP Kind highlighting
    CmpItemAbbrDeprecated = { fg = c.fg_gutter, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.cyan, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.cyan, bold = true },
    CmpItemKindArray = { fg = c.orange },
    CmpItemKindBoolean = { fg = c.orange },
    CmpItemKindClass = { fg = c.blue },
    CmpItemKindColor = { fg = c.cyan },
    CmpItemKindConstant = { fg = c.orange },
    CmpItemKindConstructor = { fg = c.blue },
    CmpItemKindDefault = { fg = c.purple },
    CmpItemKindEnum = { fg = c.blue },
    CmpItemKindEnumMember = { fg = c.purple },
    CmpItemKindEvent = { fg = c.purple },
    CmpItemKindField = { fg = c.red },
    CmpItemKindFile = { fg = c.fg },
    CmpItemKindFolder = { fg = c.blue },
    CmpItemKindFunction = { fg = c.blue },
    CmpItemKindInterface = { fg = c.cyan },
    CmpItemKindKey = { fg = c.cyan },
    CmpItemKindKeyword = { fg = c.purple },
    CmpItemKindMethod = { fg = c.blue },
    CmpItemKindModule = { fg = c.purple },
    CmpItemKindNamespace = { fg = c.purple },
    CmpItemKindNull = { fg = c.orange },
    CmpItemKindNumber = { fg = c.orange },
    CmpItemKindObject = { fg = c.blue },
    CmpItemKindOperator = { fg = c.magenta },
    CmpItemKindPackage = { fg = c.purple },
    CmpItemKindProperty = { fg = c.red },
    CmpItemKindReference = { fg = c.purple },
    CmpItemKindSnippet = { fg = c.green },
    CmpItemKindString = { fg = c.green },
    CmpItemKindStruct = { fg = c.blue },
    CmpItemKindText = { fg = c.fg },
    CmpItemKindTypeParameter = { fg = c.purple },
    CmpItemKindUnit = { fg = c.cyan },
    CmpItemKindValue = { fg = c.orange },
    CmpItemKindVariable = { fg = c.red },
  }
end

---@param hl table<string, table>
---@param fmt string
function M.kinds(hl, fmt)
  local kinds = {
    Array = "󰅪", -- CmpItemKindArray
    Boolean = "⊨", -- CmpItemKindBoolean
    Class = "󰌗", -- CmpItemKindClass
    Color = "󰏘", -- CmpItemKindColor
    Constant = "󰏿", -- CmpItemKindConstant
    Constructor = "", -- CmpItemKindConstructor
    Default = "󰟢", -- CmpItemKindDefault
    Enum = "󰕘", -- CmpItemKindEnum
    EnumMember = "", -- CmpItemKindEnumMember
    Event = "", -- CmpItemKindEvent
    Field = "󰆨", -- CmpItemKindField
    File = "󰈙", -- CmpItemKindFile
    Folder = "󰉋", -- CmpItemKindFolder
    Function = "󰊕", -- CmpItemKindFunction
    Interface = "", -- CmpItemKindInterface
    Key = "󰌋", -- CmpItemKindKey
    Keyword = "󰌋", -- CmpItemKindKeyword
    Method = "󰆧", -- CmpItemKindMethod
    Module = "", -- CmpItemKindModule
    Namespace = "󰦮", -- CmpItemKindNamespace
    Null = "󰟢", -- CmpItemKindNull
    Number = "󰎠", -- CmpItemKindNumber
    Object = "󰅩", -- CmpItemKindObject
    Operator = "󰆕", -- CmpItemKindOperator
    Package = "󰏗", -- CmpItemKindPackage
    Property = "󰜢", -- CmpItemKindProperty
    Reference = "󰈇", -- CmpItemKindReference
    Snippet = "", -- CmpItemKindSnippet
    String = "󰀬", -- CmpItemKindString
    Struct = "󰌗", -- CmpItemKindStruct
    Text = "󰉿", -- CmpItemKindText
    TypeParameter = "󰊄", -- CmpItemKindTypeParameter
    Unit = "󰑭", -- CmpItemKindUnit
    Value = "󰎠", -- CmpItemKindValue
    Variable = "󰀫", -- CmpItemKindVariable
  }

  for kind, _ in pairs(kinds) do
    local name = string.format(fmt, kind)
    local orig = "CmpItemKind" .. kind
    if hl[orig] then
      hl[name] = hl[orig]
    end
  end
end

return M
