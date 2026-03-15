local M = {}

M.url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    TelescopeFileBrowserBorder        = { fg = c.border_highlight, bg = c.bg_float },
    TelescopeFileBrowserNormal        = { fg = c.fg, bg = c.bg_float },
    TelescopeFileBrowserTitle         = { fg = c.fg_title, bg = c.bg_float },
    TelescopeFileBrowserPromptTitle   = { fg = c.fg_title, bg = c.bg_float },
    TelescopeFileBrowserHidden        = { fg = c.dark3 },
    TelescopeFileBrowserDirectory     = { fg = c.blue, bold = true },
    TelescopeFileBrowserParent        = { fg = c.orange },
  }
end

return M
