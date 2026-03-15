# TODO - Violet Void Neovim Theme

## Immediate

- [x] Fix Base16 color naming in colors/init.lua (audit shows base00-base0F missing) - 9ae4e55
- [ ] Test theme with all 70+ supported plugins
- [x] Add contrast checking utility function in audit.lua

## Improvements

### Color Palette

- [ ] Ensure violet-void (dark) has proper contrast ratios
- [ ] Verify void-light (light) meets WCAG AA (4.5:1)
- [ ] Add more violet/purple accent colors
- [x] Document color usage in colors/README.md - bb2f2cf

### Plugin Support

- [ ] Add missing popular plugins:
  - [x] neoconf.nvim - c9cd69f
  - [x] telescope-file-browser.nvim - b3a71a7
  - [ ] harpoon
  - [ ] refactoring.nvim
  - [x] spectre.nvim - e825dd4
  - [x] inc-rename.nvim
  - [ ] typescript-tools.nvim
  - [ ] rust-tools.nvim
  - [ ] go.nvim

### Testing

- [ ] Add automated tests using plenary.nvim
- [ ] Create visual regression test script
- [ ] Add CI workflow specific to nvim theme
- [ ] Test on Neovim 0.9, 0.10, nightly

### Features

- [x] Add more configuration options:
  - [x] `styles.boolean = { bold = true }` - 96f1929
  - [x] `styles.functions = { italic = true }`
  - [x] `styles.variables = {}`
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
