# violet-void-theme_nvim

A dark purple-focused Neovim colorscheme with support for 70+ plugins.

## Features

- **Dark and light variants** - `violet-void` (dark) and `void-light`
- **70+ plugin integrations** - Treesitter, LSP, completion, git, file explorers, and more
- **Base16 compatible** - Consistent color palette across the ecosystem
- **Highly configurable** - Customize colors, highlights, and styles
- **Lua-based** - Fast loading with lazy.nvim support

## Installation

### lazy.nvim

```lua
{
  "aaronedev/violet-void-theme_nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("violet-void").load()
  end,
}
```

### packer.nvim

```lua
use {
  "aaronedev/violet-void-theme_nvim",
  config = function()
    require("violet-void").load()
  end,
}
```

## Usage

```lua
-- Dark theme
vim.cmd.colorscheme("violet-void")

-- Light theme
vim.o.background = "light"
vim.cmd.colorscheme("void-light")
```

## Configuration

```lua
require("violet-void").load({
  style = "violet-void",  -- "violet-void" or "void-light"
  transparent = false,    -- Transparent background
  terminal = true,        -- Terminal colors
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
  },
  -- Override colors
  colors = {
    bg = "#0d0d1a",
    fg = "#c8c8e8",
  },
  -- Override highlights
  highlights = {
    Comment = { fg = "#6c6c8a" },
  },
})
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `style` | `string` | `"violet-void"` | Theme variant: `"violet-void"` (dark), `"void-light"` (light), or `"violet-void-high-contrast"` |
| `light_style` | `string` | `"void-light"` | Fallback style when background is light |
| `high_contrast` | `boolean` | `false` | Enable high-contrast variant for accessibility |
| `transparent` | `boolean` | `false` | Enable transparent background |
| `terminal_colors` | `boolean` | `true` | Configure terminal colors for `:terminal` |
| `day_brightness` | `number` | `1` | Brightness adjustment for light style (0-1) |
| `dim_inactive` | `boolean` | `false` | Dim inactive windows |
| `lualine_bold` | `boolean` | `true` | Use bold headers in lualine theme |
| `cache` | `boolean` | `true` | Cache theme for faster loading |
| `terminal` | `boolean` | - | Alias for `terminal_colors` |

### Style Options

Customize syntax highlighting styles:

```lua
styles = {
  comments = { italic = true, bold = false },
  keywords = { italic = true, bold = false },
  functions = { italic = false, bold = false },
  variables = { italic = false, bold = false },
  booleans = { italic = false, bold = false },
  sidebars = "normal",  -- "dark", "transparent", or "normal"
  floats = "normal",    -- "dark", "transparent", or "normal"
}
```

### Plugin Management

Control which plugins get highlight groups:

```lua
plugins = {
  all = true,           -- Enable all plugins (when not using lazy.nvim)
  auto = true,          -- Auto-detect plugins via lazy.nvim
  -- Or specify individual plugins:
  telescope = true,
  gitsigns = true,
  -- Disable specific plugins:
  neo-tree = false,
}
```

### Custom Colors

Override colors using `on_colors`:

```lua
on_colors = function(colors)
  colors.bg = "#0d0d1a"
  colors.fg = "#c8c8e8"
  colors.purple = "#7c3aed"
end,
```

### Custom Highlights

Override highlight groups using `on_highlights`:

```lua
on_highlights = function(highlights, colors)
  highlights.Comment = { fg = colors.comments, style = { italic = true } }
  highlights.Function = { fg = colors.purple, bold = true }
end,
```

### Filetype-Specific Overrides

Apply different highlights per file type:

```lua
filetypes = {
  python = {
    Function = { fg = "#ff0000" },
    Comment = { fg = "#00ff00" },
  },
  javascript = {
    -- JavaScript-specific overrides
  },
}
```

### Loading the Theme

```lua
-- Basic usage
require("violet-void").load()

-- With configuration
require("violet-void").load({
  style = "violet-void",
  transparent = true,
  styles = {
    comments = { italic = true },
  },
})

-- Or use setup() then load()
require("violet-void").setup({
  -- config options
})
vim.cmd.colorscheme("violet-void")
```

### Commands

- `:VioletHarmony [type]` - Get color harmonies. Types: `all`, `complement`, `split_complementary`, `triadic`, `analogous`, `monochromatic`, `tetradic`
- `:VioletCacheClear` - Clear the theme cache

### Terminal Colors

When enabled, the theme configures these terminal colors:

| Index | Color | Bright |
|-------|-------|--------|
| 0 | Black | 8 |
| 1 | Red | 9 |
| 2 | Green | 10 |
| 3 | Yellow | 11 |
| 4 | Blue | 12 |
| 5 | Magenta | 13 |
| 6 | Cyan | 14 |
| 7 | White | 15 |

## Supported Plugins

<details>
<summary>View full list (70+)</summary>

- **Syntax/Treesitter:** treesitter, semantic_tokens
- **LSP:** lsp, lspsaga, navic, aerial, trouble
- **Completion:** nvim-cmp, blink.cmp, mini.completion
- **Git:** gitsigns, neogit, lazygit, octo, gitgutter
- **File Explorers:** neo-tree, nvim-tree, mini.files
- **Fuzzy Finders:** telescope, fzf, mini.pick
- **Statusline/Tabline:** mini.statusline, mini.tabline, barbar, bufferline
- **Snippets:** luasnip, snacks
- **Debug:** dap, neotest
- **Motion:** leap, hop, flash, mini.jump
- **Editing:** mini.surround, mini.operators, yanky, illuminate
- **UI:** alpha, dashboard, which-key, noice, notify
- **Markdown:** render-markdown, headlines, vimwiki
- **AI:** copilot, codeium, supermaven
- **And more...**

</details>

## Structure

```
lua/violet-void/
├── init.lua           # Entry point
├── config.lua         # Configuration system
├── theme.lua          # Theme setup
├── util.lua           # Utility functions
├── colors/            # Base16 palette
│   ├── init.lua
│   ├── violet-void.lua
│   └── void-light.lua
└── groups/            # Plugin highlights
    ├── init.lua
    ├── base.lua
    ├── treesitter.lua
    └── ... (70+ integrations)
```

## Related Projects

Part of the [Violet Void ecosystem](https://github.com/aaronedev/violet-void-theme).

## License

MIT
