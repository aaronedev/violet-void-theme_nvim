local M = {}

---@type violet-void.HighlightsFn
function M.get(c, opts)
  -- stylua: ignore
  return {
    -- NeoWarrior main colors - using violet-void color palette
    NeoWarrior = { fg = c.blue7, bg = c.bg },
    NeoWarriorInverted = { fg = c.bg, bg = c.blue7 },
    NeoWarriorTextDim = { fg = c.comment },
    NeoWarriorTextDanger = { fg = c.error },
    NeoWarriorTextWarning = { fg = c.warning },
    NeoWarriorTextSuccess = { fg = c.green },
    NeoWarriorTextInfo = { fg = c.info },
    NeoWarriorTextDangerBg = { fg = c.fg, bg = c.error },
    NeoWarriorTextInfoBg = { fg = c.bg, bg = c.info },
    NeoWarriorGroup = { fg = c.info },
    NeoWarriorAnnotation = { fg = c.info },
    NeoWarriorTag = { fg = c.fg, bg = c.comment },
    NeoWarriorCurrentDate = { fg = c.bg, bg = c.info },
    NeoWarriorMarkedDate = { fg = c.fg, bg = c.green },

    -- Additional neowarrior specific highlights
    NeoWarriorHeader = { fg = c.blue7, bold = true },
    NeoWarriorFooter = { fg = c.blue7 },
    NeoWarriorBorder = { fg = c.border_highlight, bg = c.bg_float },
    NeoWarriorNormal = { fg = c.fg, bg = opts.transparent and c.none or c.bg },
    NeoWarriorFloat = { fg = c.fg, bg = c.bg_float },
    NeoWarriorTitle = { fg = c.blue7, bold = true },
    NeoWarriorCursorLine = { bg = c.bg_highlight },
    NeoWarriorVisual = { bg = c.bg_visual },
    NeoWarriorSearch = { fg = c.bg, bg = c.bg_search },
    NeoWarriorIncSearch = { fg = c.bg, bg = c.orange },
  }
end

return M
