---@param opts VioletVoid.Config
return function(opts)
  local style = opts.style or "violet-void"
  style = style == "void-light" and "violet-void" or style

  local Util = require("violet-void.util")

  ---@type Palette
  local colors = vim.deepcopy(require("violet-void.colors." .. style))

  -- Use specialized light theme color adjustment
  Util.invert_for_light(colors)

  -- Override backgrounds to be light but not pure white
  colors.bg = "#e1e2e7" -- Light gray background instead of pure white
  colors.bg_dark = "#d5d6db" -- Slightly darker for contrast
  colors.bg_dark1 = "#c9cad0" -- Even darker for panels
  colors.bg_highlight = "#e8e9ee" -- Lighter for highlights

  -- Adjust foreground colors to be darker for readability
  colors.fg = "#3f3f46" -- Dark gray text instead of inverted
  colors.fg_dark = "#52525b" -- Slightly lighter dark text
  colors.fg_gutter = "#9ca0a5" -- Gutter text

  -- Comments should be subtle but readable
  colors.comment = "#9ca0a5"

  -- Terminal black for light theme
  colors.terminal_black = "#b4b5ba"

  -- Dark colors for light theme UI elements
  colors.dark3 = "#d1d2d7"
  colors.dark5 = "#c4c5ca"

  -- Make sure git colors are visible but not too harsh
  if colors.git then
    -- Reprocess git colors with darker shades for light background
    local git_colors = vim.deepcopy(require("violet-void.colors.violet-void")).git
    Util.invert_for_light(git_colors)
    colors.git = git_colors
  end

  return colors
end
