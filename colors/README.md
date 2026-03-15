# Violet Void Color Palette

This document describes the color palette used in Violet Void and Void Light themes.

## Overview

Violet Void is a dark theme with deep blacks and vibrant violet/purple accents. Void Light is its light counterpart with carefully adjusted contrast for readability.

## Color Groups

### Backgrounds

| Color | Hex | Usage |
|-------|-----|-------|
| `bg` | `#0f0f0f` | Main background |
| `bg_dark` | `#0e0e0e` | Statusline, bottom panels |
| `bg_dark1` | `#1b1b1b` | Sidebar, darker areas |
| `bg_highlight` | `#191919` | Selection, cursor line |

### Foregrounds

| Color | Hex | Usage |
|-------|-----|-------|
| `fg` | `#f0f0f5` | Main text |
| `fg_dark` | `#303030` | Status bar text |
| `fg_gutter` | `#313131` | Gutter line numbers |

### Accent Colors

| Color | Hex | Usage |
|-------|-----|-------|
| `purple` | `#bb7cff` | Primary accent, keywords |
| `magenta` | `#fd7cff` | Secondary accent, special |
| `blue` | `#29adff` | Links, info |
| `cyan` | `#00fff9` | Strings, constants |
| `green` | `#42ff97` | Success, additions |
| `orange` | `#ff7c7e` | Warnings, numbers |
| `red` | `#ff004b` | Errors, deletions |
| `yellow` | `#7c60d1` | (Violet-tinted yellow for theme identity) |

### Utility Colors

| Color | Hex | Usage |
|-------|-----|-------|
| `comment` | `#4c4c4c` | Comments, disabled text |
| `dark3` | `#212121` | Subtle borders |
| `dark5` | `#242424` | Line numbers, folds |

## Extended Palette

### Version Variants

| Color | Hex | Usage |
|-------|-----|-------|
| `blue0` | `#70c8ff` | Bright blue variant |
| `blue1` | `#b6e3ff` | Light blue variant |
| `blue2` | `#2cbecf` | Teal-blue variant |
| `blue5` | `#00a8a4` | Dark cyan variant |
| `blue6` | `#b4f9f8` | Light cyan variant |
| `blue7` | `#4b8afe` | Royal blue variant |
| `green1` | `#42ffad` | Bright green |
| `green2` | `#08bdba` | Teal green |
| `magenta2` | `#fd0098` | Deep magenta |
| `red1` | `#ff1a67` | Normal red |

### Git Colors

| Color | Hex | Usage |
|-------|-----|-------|
| `git.add` | `#144f36` | Git additions (bg) |
| `git.change` | `#004f4d` | Git changes (bg) |
| `git.delete` | `#4f0017` | Git deletions (bg) |

## Base16 Compatibility

For Base16 scheme compatibility, colors map as follows:

| Base16 | Hex | Description |
|--------|-----|-------------|
| base00 | `#0f0f0f` | Default Background |
| base01 | `#0e0e0e` | Lighter Background |
| base02 | `#1b1b1b` | Selection Background |
| base03 | `#4c4c4c` | Comments, Invisibles |
| base04 | `#303030` | Dark Foreground |
| base05 | `#f0f0f5` | Default Foreground |
| base06 | `#f0f0f5` | Light Foreground |
| base07 | `#ffffff` | Lightest Foreground |
| base08 | `#ff004b` | Red |
| base09 | `#ff7c7e` | Orange |
| base0A | `#7c60d1` | Yellow (violet-tinted) |
| base0B | `#42ff97` | Green |
| base0C | `#00fff9` | Cyan |
| base0D | `#29adff` | Blue |
| base0E | `#bb7cff` | Purple |
| base0F | `#fd7cff` | Magenta |

## Semantic Colors

These colors are derived and used for specific purposes:

| Color | Derived From | Usage |
|-------|--------------|-------|
| `error` | `red1` | Error messages |
| `warning` | `orange` (blended) | Warning messages |
| `info` | `blue2` | Informational messages |
| `hint` | `teal` | Hint messages |
| `diff.add` | `green` (blended) | Diff additions |
| `diff.delete` | `red` (blended) | Diff deletions |
| `diff.change` | `blue5` (blended) | Diff changes |
| `bg_visual` | `yellow` (blended) | Visual selection |
| `bg_search` | `blue7` (blended) | Search highlights |

## Terminal Colors

For terminal emulator integration:

```
black        → #121212 blend
red          → #ff004b
green        → #42ff97
yellow       → #7c60d1
blue         → #29adff
magenta      → #fd7cff
cyan         → #00fff9
white        → #303030
```

## Void Light Adjustments

Void Light inverts most colors for light backgrounds while maintaining:

- `bg`: `#e1e2e7` (light gray, not pure white)
- `fg`: `#3f3f46` (dark gray for readability)
- Accent colors remain vibrant but adjusted for contrast
- Git colors are reprocessed for visibility

## Usage in Plugins

Plugin highlights should use these semantic color references:

```lua
-- Example: Creating highlights for a plugin
return {
  PluginNormal = { fg = c.fg, bg = c.bg_float },
  PluginBorder = { fg = c.border_highlight, bg = c.bg_float },
  PluginTitle = { fg = c.purple, bold = true },
}
```

Always reference `c` (the color scheme) rather than hardcoding hex values to maintain theme consistency.
