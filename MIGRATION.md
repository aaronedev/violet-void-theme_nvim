# Migration Guide

Guide for migrating from popular colorschemes to Violet Void.

## From Tokyo Night

```lua
-- Tokyo Night
vim.cmd("colorscheme tokyonight")

-- Replace with Violet Void
vim.cmd("colorscheme violet-void")
-- or with setup()
require("violet-void").load()
```

### Key Differences

| Tokyo Night | Violet Void |
|-------------|-------------|
| `tokyo-night` | `violet-void` |
| `tokyo-night-storm` | `violet-void` |
| `tokyo-night-moon` | `violet-void-high-contrast` |
| `tokyo-night-day` | `void-light` |

### Equivalent Settings

```lua
-- Tokyo Night config
require("tokyo-night").setup({
  style = "storm",
  transparent = true,
  terminal_colors = true,
})

-- Violet Void equivalent
require("violet-void").load({
  style = "violet-void",
  transparent = true,
  terminal_colors = true,
})
```

---

## From Catppuccin

```lua
-- Catppuccin
vim.cmd("colorscheme catppuccin")

-- Replace with Violet Void
vim.cmd("colorscheme violet-void")
```

### Key Differences

| Catppuccin | Violet Void |
|------------|-------------|
| `catppuccin-latte` | `void-light` |
| `catppuccin-frappe` | `violet-void` |
| `catppuccin-macchiato` | `violet-void` |
| `catppuccin-mocha` | `violet-void` |

### Equivalent Settings

```lua
-- Catppuccin config
require("catppuccin").setup({
  transparent_background = true,
  flavor = "mocha",
})

-- Violet Void equivalent
require("violet-void").load({
  transparent = true,
  style = "violet-void",
})
```

### Translating Custom Highlights

```lua
-- Catppuccin
require("catppuccin").setup({
  integrations = {
    telescope = true,
    gitsigns = true,
  },
})

-- Violet Void handles plugins automatically via lazy.nvim detection
-- or explicit:
require("violet-void").load({
  plugins = {
    telescope = true,
    gitsigns = true,
  },
})
```

---

## From One Dark

```lua
-- One Dark
vim.cmd("colorscheme one-dark")

-- Replace with Violet Void
vim.cmd("colorscheme violet-void")
```

### Key Differences

| One Dark | Violet Void |
|----------|--------------|
| `one-dark` | `violet-void` |
| `onedark` (variant) | `violet-void` |

### Equivalent Settings

```lua
-- One Dark config
require("onedark").setup({
  style = "dark",
  transparent = true,
})

-- Violet Void equivalent
require("violet-void").load({
  style = "violet-void",
  transparent = true,
})
```

---

## From Nord

```lua
-- Nord
vim.cmd("colorscheme nord")

-- Replace with Violet Void
vim.cmd("colorscheme violet-void")
```

### Color Philosophy

Nord is a polar night palette (blue-grey), while Violet Void embraces purple/violet tones. The mood is similar but with warmer accent colors.

---

## From Gruvbox

```lua
-- Gruvbox
vim.cmd("colorscheme gruvbox")

-- Replace with Violet Void
vim.cmd("colorscheme violet-void")
```

### Key Differences

| Gruvbox | Violet Void |
|---------|-------------|
| `gruvbox` (dark) | `violet-void` |
| `gruvbox` (light) | `void-light` |

---

## From Dracula

```lua
-- Dracula
vim.cmd("colorscheme dracula")

-- Replace with Violet Void
vim.cmd("colorscheme violet-void")
```

### Similarities

Both themes share a dark purple/pink accent aesthetic. Violet Void offers more configuration options and a light variant.

---

## Common Migrations

### Transparent Background

```lua
-- Most themes
transparent = true

-- Violet Void
require("violet-void").load({
  transparent = true,
})
```

### Custom Colors

```lua
-- Old theme
vim.api.nvim_set_hl(0, "Function", { fg = "#ff0000" })

-- Violet Void (using on_highlights)
require("violet-void").load({
  on_highlights = function(highlights, colors)
    highlights.Function = { fg = colors.purple }
  end,
})
```

### Plugin Integrations

Most themes require manual integration configuration. Violet Void auto-detects plugins via lazy.nvim:

```lua
-- No config needed if using lazy.nvim with plugin specs
-- Manual enabling:
require("violet-void").load({
  plugins = {
    telescope = true,
    gitsigns = true,
    treesitter = true,
  },
})
```

---

## Troubleshooting

### Theme Not Loading

```lua
-- Ensure theme is loaded after plugins
require("violet-void").load()

-- Or use setup() + colorscheme
require("violet-void").setup({})
vim.cmd.colorscheme("violet-void")
```

### Wrong Colors in Terminal

```lua
-- Enable terminal colors
require("violet-void").load({
  terminal_colors = true,
})
```

### Lualine/Statusline Wrong Colors

```lua
-- Violet Void includes lualine theme
require("lualine").setup({
  options = {
    theme = "violet-void",
  },
})
```

---

## Getting Help

- Issues: https://github.com/aaronedev/violet-void-theme/issues
- Discussions: https://github.com/aaronedev/violet-void-theme/discussions
