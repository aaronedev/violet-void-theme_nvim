local M = {}

M.url = "https://github.com/simrat39/rust-tools.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    RustAnalyzerInlayHint      = { fg = c.comment },
    RustAnalyzerInlineHint     = { fg = c.comment },
    RustMacroAttribute          = { fg = c.purple },
    RustDerive                  = { fg = c.purple },
    RustDeriveTrait            = { fg = c.magenta },
    RustConst                  = { fg = c.magenta },
    RustStatic                 = { fg = c.magenta, style = { "italic" } },
    RustFunc                    = { fg = c.cyan },
    RustMethod                 = { fg = c.cyan },
    RustTrait                  = { fg = c.magenta },
    RustType                   = { fg = c.purple },
    RustTypeAlias              = { fg = c.purple1 },
    RustEnum                   = { fg = c.purple },
    RustEnumVariant            = { fg = c.purple },
    RustStruct                 = { fg = c.blue1 },
    RustLifetime              = { fg = c.orange },
    RustLabel                  = { fg = c.yellow },
    RustGenericParameter       = { fg = c.orange },
    RustSelf                   = { fg = c.magenta },
    RustSuperTrait            = { fg = c.cyan },
    RustWherePredicate         = { fg = c.fg },
  }
end

return M
