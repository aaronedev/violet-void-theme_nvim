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
