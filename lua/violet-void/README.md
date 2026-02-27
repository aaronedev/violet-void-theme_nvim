# violet-void

  lua/violet-void/               # Main theme module
  ├── init.lua                   # Entry point
  ├── config.lua                 # Configuration system
  ├── theme.lua                  # Theme setup
  ├── util.lua                   # Utility functions
  ├── colors/init.lua            # Your base16 colors
  └── groups/                    # Highlight groups
      ├── init.lua               # Plugin management
      ├── base.lua               # Core vim highlights
      ├── treesitter.lua         # Treesitter highlights
      ├── kinds.lua              # LSP kinds
      └── semantic_tokens.lua    # LSP semantic tokens

  colors/violet-void.lua         # Colorscheme entry point
  lua/plugins/violet-void.lua    # Lazy.nvim configuration

  1. Lazy.nvim loads your theme via lua/plugins/violet-void.lua
  2. Configuration happens in the plugin file with full customization options
  3. Your base16 colors are preserved in the modular structure
  4. Plugin highlights are automatically detected and applied
