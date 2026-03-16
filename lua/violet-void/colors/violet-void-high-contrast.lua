---@type Palette
--- High-contrast variant for accessibility - enhanced contrast ratios for better visibility
return {
  bg = "#080808",
  bg_dark = "#050505",
  bg_dark1 = "#111111",
  bg_highlight = "#1a1a1a",
  blue = "#4dc8ff",
  blue0 = "#9ae0ff",
  blue1 = "#d4f4ff",
  blue2 = "#3fe4e4",
  blue5 = "#12d4d0",
  blue6 = "#d4ffff",
  blue7 = "#82b4ff",
  comment = "#606060",
  cyan = "#40ffff",
  dark3 = "#2a2a2a",
  dark5 = "#2e2e2e",
  fg = "#ffffff",
  fg_dark = "#4a4a4a",
  fg_gutter = "#484848",
  green = "#6affc4",
  green1 = "#8affd6",
  green2 = "#20d4cc",
  magenta = "#ff8cff",
  magenta2 = "#ff40b8",
  orange = "#ff8a8c",
  purple = "#d4a8ff",
  purple1 = "#b880ff",
  purple2 = "#d8b8ff",
  purple3 = "#a06cff",
  purple4 = "#f4ecff",
  violet = "#a78bff",
  violet1 = "#c4b8ff",
  lavender = "#f0ecff",
  red = "#ff4d6a",
  red1 = "#ff2d58",
  terminal_black = "#0a0a0a",
  teal = "#52b8a8",
  yellow = "#9d80e0",
  git = {
    add = "#1a6f4a",
    change = "#0a7a78",
    delete = "#7f0028",
  },

  -- Base16 color names for compatibility
  base00 = "#080808", -- Default Background
  base01 = "#050505", -- Lighter Background (statusline)
  base02 = "#111111", -- Selection Background
  base03 = "#606060", -- Comments, Invisibles
  base04 = "#4a4a4a", -- Dark Foreground (statusbar)
  base05 = "#ffffff", -- Default Foreground
  base06 = "#ffffff", -- Light Foreground (unused)
  base07 = "#ffffff", -- Lightest Foreground (unused)
  base08 = "#ff4d6a", -- Red
  base09 = "#ff8a8c", -- Orange
  base0A = "#9d80e0", -- Yellow (using violet for theme identity)
  base0B = "#6affc4", -- Green
  base0C = "#40ffff", -- Cyan
  base0D = "#4dc8ff", -- Blue
  base0E = "#d4a8ff", -- Purple
  base0F = "#ff8cff", -- Magenta
}
