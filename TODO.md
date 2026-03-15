# TODO - Violet Void Neovim Theme

## Immediate

- [x] Fix Base16 color naming in colors/init.lua (audit shows base00-base0F missing) - 9ae4e55
- [ ] Test theme with all 70+ supported plugins
- [ ] Add contrast checking utility function in audit.lua

## Improvements

### Color Palette

- [ ] Ensure violet-void (dark) has proper contrast ratios
- [ ] Verify void-light (light) meets WCAG AA (4.5:1)
- [ ] Add more violet/purple accent colors
- [ ] Document color usage in colors/README.md

### Plugin Support

- [ ] Add missing popular plugins:
  - [ ] neoconf.nvim
  - [ ] telescope-file-browser.nvim
  - [ ] harpoon
  - [ ] refactoring.nvim
  - [ ] spectre.nvim
  - [ ] inc-rename.nvim
  - [ ] typescript-tools.nvim
  - [ ] rust-tools.nvim
  - [ ] go.nvim

### Testing

- [ ] Add automated tests using plenary.nvim
- [ ] Create visual regression test script
- [ ] Add CI workflow specific to nvim theme
- [ ] Test on Neovim 0.9, 0.10, nightly

### Features

- [ ] Add more configuration options:
  - [ ] `styles.boolean = { bold = true }`
  - [ ] `styles.functions = { italic = true }`
  - [ ] `styles.variables = {}`
- [ ] Add colorblind-friendly variant
- [ ] Add high-contrast variant for accessibility
- [ ] Support for custom color overrides per-filetype

### Documentation

- [ ] Add screenshots to README
- [ ] Document all configuration options
- [ ] Add migration guide from other colorschemes
- [ ] Create demo video/gifs

### Performance

- [ ] Profile theme load time
- [ ] Optimize highlight generation
- [ ] Consider lazy-loading for rarely-used plugins

## Known Issues

- [ ] Base16 colors not properly named (uses bg/fg/etc instead of base00-base0F)
- [ ] Some plugin groups may need contrast adjustments

## Future

- [ ] Support for nvim 0.11+ features
- [ ] LSP semantic token improvements
- [ ] Treesitter 0.10+ captures
- [ ] Export to other formats (VS Code, Sublime Text, etc.)
