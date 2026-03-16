# TODO - Violet Void Neovim Theme

## Immediate

- [x] Fix Base16 color naming in colors/init.lua (audit shows base00-base0F missing) - 9ae4e55
- [ ] Test theme with all 70+ supported plugins
- [x] Add contrast checking utility function in audit.lua

## Improvements

### Color Palette

- [x] Ensure violet-void (dark) has proper contrast ratios - 1ac2b12
- [x] Verify void-light (light) meets WCAG AA (4.5:1) - 1ac2b12
- [x] Add more violet/purple accent colors - 4aed211
- [x] Document color usage in colors/README.md - bb2f2cf

### Plugin Support

- [ ] Add missing popular plugins:
  - [x] neoconf.nvim - c9cd69f
  - [x] telescope-file-browser.nvim - b3a71a7
  - [x] harpoon - a421308
  - [x] refactoring.nvim - 58f6597
  - [x] spectre.nvim - e825dd4
  - [x] inc-rename.nvim - 8668317
  - [x] typescript-tools.nvim - a421308
  - [x] rust-tools.nvim - a421308
  - [x] go.nvim - a421308
  - [x] toggleterm.nvim - f293940

### Testing

- [x] Add automated tests using plenary.nvim
- [x] Create visual regression test script - 054ce94
- [x] Add CI workflow specific to nvim theme - 2b57a4d
- [ ] Test on Neovim 0.9, 0.10, nightly

### Features

- [x] Add more configuration options:
  - [x] `styles.boolean = { bold = true }` - 96f1929
  - [x] `styles.functions = { italic = true }`
  - [x] `styles.variables = {}`
- [x] Add high-contrast variant for accessibility
- [x] Add colorblind-friendly variant - 6fe2604
- [x] Support for custom color overrides per-filetype - 8668317

### Documentation

- [ ] Add screenshots to README
- [x] Document all configuration options - e35d75a
- [x] Add migration guide from other colorschemes
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
