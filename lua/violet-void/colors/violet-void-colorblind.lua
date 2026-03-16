--- Colorblind-friendly variant of Violet Void
--- Optimized for: Deuteranopia, Protanopia, and Tritanopia
--- Maintains the violet aesthetic while ensuring distinguishable colors
---@type Palette
return {
  -- Base backgrounds (unchanged)
  bg = "#0f0f0f",
  bg_dark = "#0e0e0e",
  bg_dark1 = "#1b1b1b",
  bg_highlight = "#191919",
  
  -- Adjusted for colorblind accessibility:
  -- Blue family (safe for most colorblind types)
  blue = "#29adff",
  blue0 = "#70c8ff",
  blue1 = "#b6e3ff",
  blue2 = "#2cbecf",
  blue5 = "#00a8a4",
  blue6 = "#b4f9f8",
  blue7 = "#4b8afe",
  
  -- Comments - use neutral gray
  comment = "#6b6b6b",
  
  -- Cyan is colorblind-safe (works for all types)
  cyan = "#00fff9",
  
  -- Dark variants
  dark3 = "#212121",
  dark5 = "#242424",
  
  -- Foreground
  fg = "#f0f0f5",
  fg_dark = "#505050",
  fg_gutter = "#404040",
  
  -- Green: shift toward teal/cyan for deuteranopia
  -- Original: #42ff97 -> Safe: #20d4b4 (more teal, distinguishable from orange)
  green = "#20d4b4",
  green1 = "#3de0c8",
  green2 = "#08bdba",
  
  -- Magenta: safe for most colorblind types
  magenta = "#ff7cff",
  magenta2 = "#ff40b0",
  
  -- Orange: shift to be more distinguishable from red/green
  -- Original: #ff7c7e -> Safe: #ff9040 (more orange, less red)
  orange = "#ff9040",
  
  -- Purple family: safe, distinguish from blue with warmth
  purple = "#c090ff",
  purple1 = "#b070ff",
  purple2 = "#d8b8ff",
  purple3 = "#9966ff",
  purple4 = "#e8d8ff",
  
  -- Violet: safe for colorblind
  violet = "#9d7dff",
  violet1 = "#b8a0ff",
  lavender = "#e8d8ff",
  
  -- Red: shift toward magenta/orange for better distinction
  -- Original: #ff004b -> Safe: #ff3366 (more distinguishable from green)
  red = "#ff3366",
  red1 = "#ff4070",
  
  -- Terminal black
  terminal_black = "#181818",
  
  -- Teal (colorblind-safe)
  teal = "#20b4aa",
  
  -- Yellow: shift toward amber for tritanopia
  -- Original: #7c60d1 (violet) -> Safe: #c9a030 (amber/gold)
  yellow = "#c9a030",
  
  -- Git colors - adjusted for colorblind accessibility
  git = {
    -- Green -> Teal for add
    add = "#0d4d42",
    -- Blue -> Purple for change
    change = "#2d2060",
    -- Red -> Magenta/Pink for delete
    delete = "#4d1030",
  },

  -- Base16 color names (adjusted for colorblind accessibility)
  base00 = "#0f0f0f", -- Default Background
  base01 = "#0e0e0e", -- Lighter Background (statusline)
  base02 = "#1b1b1b", -- Selection Background
  base03 = "#6b6b6b", -- Comments, Invisibles (neutral gray)
  base04 = "#505050", -- Dark Foreground (statusbar)
  base05 = "#f0f0f5", -- Default Foreground
  base06 = "#f0f0f5", -- Light Foreground (unused)
  base07 = "#ffffff", -- Lightest Foreground (unused)
  base08 = "#ff3366", -- Red (shifted toward magenta)
  base09 = "#ff9040", -- Orange (more distinct from red/green)
  base0A = "#c9a030", -- Yellow (amber/gold for tritanopia)
  base0B = "#20d4b4", -- Green (teal for deuteranopia)
  base0C = "#00fff9", -- Cyan (colorblind safe)
  base0D = "#29adff", -- Blue
  base0E = "#c090ff", -- Purple
  base0F = "#ff7cff", -- Magenta
}
