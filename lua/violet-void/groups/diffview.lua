local M = {}

M.url = "https://github.com/sindrets/diffview.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    DiffviewDiffAddAsDelete = { fg = c.git.delete, bg = c.diff.delete },
    DiffviewDiffDelete      = { fg = c.git.delete, bg = c.diff.delete },
    DiffviewDiffDeleteDim   = { fg = c.fg_dark, bg = c.diff.delete },
    DiffviewFilePanelTitle  = { fg = c.purple, bold = true },
    DiffviewStatusAdded    = { fg = c.git.add },
    DiffviewStatusBroken   = { fg = c.red },
    DiffviewStatusCopied   = { fg = c.cyan },
    DiffviewStatusDeleted  = { fg = c.git.delete },
    DiffviewStatusIgnored  = { fg = c.fg_dark, strikethrough = true },
    DiffviewStatusModified = { fg = c.git.change },
    DiffviewStatusRenamed  = { fg = c.cyan },
    DiffviewStatusTypeChanged = { fg = c.orange },
    DiffviewStatusUnknown  = { fg = c.red },
    DiffviewStatusUnmerged = { fg = c.magenta },
    DiffviewStatusUntracked = { fg = c.purple },
  }
end

return M
