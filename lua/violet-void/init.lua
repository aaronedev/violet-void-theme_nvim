local config = require("violet-void.config")

local M = {}
---@type {light?: string, dark?: string}
M.styles = {}

---@param opts? VioletVoid.Config
function M.load(opts)
  opts = require("violet-void.config").extend(opts)
  local bg = vim.o.background
  local style_bg = opts.style == "void-light" and "light" or "dark"

  if bg ~= style_bg then
    if vim.g.colors_name == "violet-void" or vim.g.colors_name == "void-light" then
      opts.style = bg == "light" and (M.styles.light or opts.light_style or "void-light")
        or (M.styles.dark or "violet-void")
    else
      vim.o.background = style_bg
    end
  end
  M.styles[vim.o.background] = opts.style
  return require("violet-void.theme").setup(opts)
end

M.setup = config.setup

-- Expose profiling API
M.profile = {
  --- Enable or disable profiling
  set_enabled = function(enabled)
    require("violet-void.theme").set_profile(enabled)
  end,
  --- Get profiling results
  get_timings = function()
    return require("violet-void.theme").get_profile()
  end,
}

return M
