# Neovim Configuration - Native Features Edition

This configuration leverages Neovim 0.11+ native features to minimize plugin dependencies while maintaining full LSP functionality.

## 📋 Quick Start

Your configuration is already updated and ready to use! Just restart Neovim.

## 📚 Documentation

### Essential Reading
1. **[CHANGES_SUMMARY.md](CHANGES_SUMMARY.md)** - What changed and why
2. **[KEYMAPS_REFERENCE.md](KEYMAPS_REFERENCE.md)** - Quick reference for all keymaps

### Detailed Guides
3. **[NATIVE_FEATURES.md](NATIVE_FEATURES.md)** - Complete guide to native features
4. **[PLUGIN_REMOVAL_GUIDE.md](PLUGIN_REMOVAL_GUIDE.md)** - How to simplify further

### Optional Configuration
5. **[lua/native-completion.lua](lua/native-completion.lua)** - Pure native completion setup

## ✨ What's New

### Native Features Enabled
- ✅ **vim.snippet** - Native snippet support (no more vim-vsnip)
- ✅ **vim.lsp.completion** - Native LSP completion
- ✅ **vim.lsp.config/enable** - Native LSP server management
- ✅ **vim.lsp.inlay_hint** - Native inlay hints
- ✅ **vim.diagnostic** - Native diagnostics with custom signs
- ✅ **Modern APIs** - No deprecated function calls

### Plugins Removed
- ❌ vim-vsnip
- ❌ cmp-vsnip

### Key Improvements
- 🚀 **Faster startup** - Fewer plugins to load
- 🔧 **Simpler config** - Using native APIs
- 📦 **Fewer dependencies** - Less to maintain
- 🎯 **Future-proof** - Using official Neovim APIs

## 🎮 Essential Keymaps

### Snippets (NEW)
- `<C-f>` - Jump to next snippet field
- `<C-b>` - Jump to previous snippet field

### Completion
- `<C-Space>` - Trigger completion
- `<Tab>` / `<S-Tab>` - Navigate items
- `<CR>` - Accept completion

### LSP
- `gd` - Go to definition
- `grr` - List references
- `grn` - Rename
- `gra` - Code action
- `K` - Hover documentation
- `<leader>h` - Toggle inlay hints

See [KEYMAPS_REFERENCE.md](KEYMAPS_REFERENCE.md) for complete list.

## ⚙️ Current Setup

### Completion Strategy
**Hybrid Approach** (Recommended):
- Native LSP completion enabled
- nvim-cmp enhanced completion active
- Best of both worlds

**Want simpler?** See [PLUGIN_REMOVAL_GUIDE.md](PLUGIN_REMOVAL_GUIDE.md) to use only native completion.

### LSP Servers (via Mason)
- TypeScript/JavaScript (ts_ls)
- Rust (rust_analyzer)
- Go (gopls)
- Lua (lua_ls)
- JSON (jsonls)
- YAML (yamlls)
- Bash (bashls)
- Markdown (prosemd_lsp)
- Terraform (terraformls)

### Formatters (via Conform)
- Lua: stylua
- JS/TS: prettier
- Go: gofumpt, goimports
- Rust: rustfmt
- Shell: shfmt
- And more...

### Linters (via nvim-lint)
- JS/TS: oxlint
- Shell: shellcheck
- JSON: jsonlint
- YAML: yamllint
- And more...

## 🔍 Health Check

After starting Neovim, run:

```vim
:checkhealth
```

Everything should be green! ✅

## 🐛 Troubleshooting

### Snippets not working
- Check Neovim version: `:version` (need 0.10+)
- Test manually: `:lua vim.snippet.expand("test")`

### Completion not appearing
- Check LSP: `:LspInfo`
- Check server attached: Look for "Attached" status
- Try manual trigger: `<C-Space>` or `<C-x><C-o>`

### Inlay hints not showing
- Toggle them: `<leader>h`
- Check support: Not all servers support inlay hints

### Want the old setup back?
```bash
git checkout HEAD~1 -- lua/plugins/nvim-cmp.lua lua/plugins/nvim-lspconfig.lua
```

## 📊 System Requirements

- **Neovim**: 0.11.0+ (you have 0.11.3 ✅)
- **Git**: For plugin management
- **Node.js**: For some LSP servers
- **Language tools**: See Mason for auto-install

## 🚀 Next Steps

1. ✅ Restart Neovim - Changes are already applied!
2. 📖 Read [CHANGES_SUMMARY.md](CHANGES_SUMMARY.md)
3. 🎯 Try the new snippet navigation (`<C-f>`, `<C-b>`)
4. 🧪 Test LSP features (`:LspInfo`, hover with `K`)
5. 💡 Consider removing more plugins (see [PLUGIN_REMOVAL_GUIDE.md](PLUGIN_REMOVAL_GUIDE.md))

## 📦 Plugin Overview

### Core (Required)
- lazy.nvim - Plugin manager
- nvim-lspconfig - LSP configurations
- mason.nvim - Tool installer
- mason-tool-installer.nvim - Auto-install

### LSP Enhancements (Recommended)
- fidget.nvim - Progress notifications
- telescope.nvim - Fuzzy finder for LSP features

### Completion (Optional)
- nvim-cmp - Enhanced completion
  - *Can be removed to use only native completion*

### Other Utilities
- conform.nvim - Formatting
- nvim-lint - Linting
- gitsigns.nvim - Git integration
- nvim-treesitter - Syntax highlighting
- And more...

## 🎓 Learning Resources

- `:help vim.lsp`
- `:help vim.snippet`
- `:help vim.diagnostic`
- `:help completion`
- [Neovim Documentation](https://neovim.io/doc/)

## 📝 Notes

- All changes are **backwards compatible**
- Your existing keymaps still work
- No breaking changes to your workflow
- Opt-in to more minimal setups via guides

## 🙏 Credits

This configuration uses native Neovim features introduced in versions 0.10 and 0.11, reducing the need for external plugins while maintaining a powerful development environment.

---

**Status**: ✅ Ready to use!
**Neovim Version**: 0.11.3
**Last Updated**: 2025

Enjoy your modernized Neovim setup! 🎉
