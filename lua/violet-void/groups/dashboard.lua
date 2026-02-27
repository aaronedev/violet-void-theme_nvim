local M = {}

M.url = "https://github.com/nvimdev/dashboard-nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    -- General
    DashboardHeader           = { fg = c.blue5},
    DashboardFooter           = { fg = c.comment},
    -- Hyper theme
    DashboardProjectTitle     = { fg = c.magenta},
    DashboardProjectTitleIcon = { fg = c.orange },
    DashboardProjectIcon      = { fg = c.yellow },
    DashboardMruTitle         = { fg = c.cyan },
    DashboardMruIcon          = { fg = c.purple },
    DashboardFiles            = { fg = c.blue },
    DashboardShortCutIcon     = { fg = c.magenta },
    -- Doome theme
    DashboardDesc             = { fg = c.yellow},
    DashboardKey              = { fg = c.magenta},
    DashboardIcon             = { fg = c.magenta},
    DashboardShortCut         = { fg = c.cyan },
  }
end

return M
