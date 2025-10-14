# Neovim Configuration

**Version:** Modern & Optimized  
**Neovim:** 0.11.4+  
**Philosophy:** Native-first, Performance-focused, Well-documented

---

## 🚀 Quick Start

New to this config? **Start here:**

📖 **[QUICK_START.md](QUICK_START.md)** - Get up and running in 5 minutes

---

## 📚 Documentation

### Essential Reading
- **[QUICK_START.md](QUICK_START.md)** - Quick setup and testing guide
- **[KEYMAPS.md](KEYMAPS.md)** - Complete keymap reference (100+ keymaps)
- **[FINAL_REPORT.md](FINAL_REPORT.md)** - Configuration analysis & assessment

### Advanced Reading
- **[CONFIG_REVIEW_AND_RECOMMENDATIONS.md](CONFIG_REVIEW_AND_RECOMMENDATIONS.md)** - Detailed analysis
- **[IMPROVEMENTS_SUMMARY.md](IMPROVEMENTS_SUMMARY.md)** - Recent changes
- **[.improvements-log.txt](.improvements-log.txt)** - Change log

---

## ✨ Features

### Native Neovim Features (0.11+)
- ✅ **Native LSP Completion** - `vim.lsp.completion` (no nvim-cmp)
- ✅ **Native Snippets** - `vim.snippet` (no snippet plugins)
- ✅ **Native Diagnostics** - `vim.diagnostic` with modern config
- ✅ **Native Inlay Hints** - `vim.lsp.inlay_hint`
- ✅ **Native Formatting** - `vim.lsp.buf.format` (no conform.nvim)
- ✅ **Module Caching** - `vim.loader.enable()` for speed

### Essential Plugins
- **Editing:**
  - `mini.comment` - Code commenting
  - `nvim-surround` - Text surrounding
  - `nvim-autopairs` - Auto-close pairs
  - `nvim-spider` - Better word motions
- **Navigation:**
  - `telescope.nvim` - Fuzzy finder
  - `nvim-tree` - File explorer
  - `barbar.nvim` - Buffer/tab management
- **LSP & Completion:**
  - `nvim-lspconfig` - LSP configuration
  - `typescript-tools.nvim` - Enhanced TypeScript
  - `rustaceanvim` - Best-in-class Rust support
  - `biome` - Modern JS/TS formatting/linting
- **UI Enhancement:**
  - `dressing.nvim` - Better dialogs
  - `which-key.nvim` - Keymap discovery
  - `lualine.nvim` - Status line
  - `gitsigns.nvim` - Git integration
- **Utilities:**
  - `nvim-treesitter` - Syntax highlighting
  - `nvim-ufo` - Better folding
  - `todo-comments.nvim` - TODO highlighting
  - `nvim-spectre` - Search & replace

### Language Support
- **JavaScript/TypeScript** - Biome + typescript-tools
- **Rust** - rustaceanvim + rust-analyzer
- **Lua** - lua_ls + stylua
- **Go** - gopls + gofumpt
- **JSON** - Biome + jsonls
- **YAML** - yamlls + yamlfmt
- **Markdown** - prosemd + markdownlint
- **Bash** - bashls + shellcheck

---

## ⌨️ Key Bindings

### Most Used (Quick Reference)

| Action | Keymap | Plugin |
|--------|--------|--------|
| Comment line | `gcc` | mini.comment |
| Find files | `<leader>ff` | Telescope |
| Live grep | `<leader>fg` | Telescope |
| Go to definition | `gd` | LSP |
| Code action | `gra` | LSP |
| Rename | `grn` | LSP |
| Format | `<leader>f` | LSP |
| Show keymaps | `<leader>` + wait | which-key |
| File tree | `<leader>e` | nvim-tree |
| Next buffer | `<A-.>` | barbar |

**Full reference:** See [KEYMAPS.md](KEYMAPS.md)

---

## 📊 Stats

- **Plugins:** ~31 (essential only)
- **Startup Time:** ~60-90ms (very fast)
- **Lines of Config:** ~2500 (well-organized)
- **Documentation:** 6 comprehensive guides
- **Keymaps:** 100+ (all documented)

---

## 🎯 Philosophy

### 1. Native-First
Use Neovim's native features when available instead of plugins:
- Native completion > nvim-cmp
- Native formatting > conform.nvim
- Native snippets > snippet plugins
- Native diagnostics > custom implementations

### 2. Performance-Focused
- Lazy load everything possible
- Use native features (faster than plugins)
- Enable module caching
- Minimal dependencies

### 3. Well-Documented
- Every plugin has a clear purpose
- Every keymap has a description
- Multiple reference guides
- Clear inline comments

### 4. Modern & Maintained
- Use actively maintained plugins
- Prefer Lua over Vimscript
- Stay updated with Neovim releases
- Replace deprecated patterns

---

## 🛠️ Installation

### Prerequisites
```bash
# Neovim 0.11.4 or later
nvim --version

# Required tools (install via Mason or package manager)
# - LSP servers: typescript-language-server, rust-analyzer, lua-language-server, etc.
# - Formatters: biome, stylua, etc.
# - Linters: shellcheck, etc.
```

### Setup
```bash
# 1. Clone or copy this config to ~/.config/nvim

# 2. Open Neovim (plugins will auto-install)
nvim

# 3. Sync plugins
:Lazy sync

# 4. Install LSP servers/tools
:Mason

# 5. Check health
:checkhealth
```

### First Time Users
Read [QUICK_START.md](QUICK_START.md) for a guided walkthrough.

---

## 🔧 Customization

### File Structure
```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── settings.lua         # Neovim options
│   ├── keymaps.lua          # General keymaps
│   ├── plugins-bootstrap.lua # Lazy.nvim setup
│   └── plugins/             # Plugin configurations
│       ├── nvim-lspconfig.lua    # LSP setup
│       ├── typescript-tools.lua  # TypeScript
│       ├── rustaceanvim.lua      # Rust
│       ├── telescope.lua         # Fuzzy finder
│       ├── mini-comment.lua      # Commenting
│       ├── nvim-surround.lua     # Surround
│       ├── which-key.lua         # Keymap helper
│       ├── dressing.lua          # UI enhancement
│       └── ... (28 total)
└── ftplugin/                # Filetype-specific settings
```

### Common Customizations

**Change leader key:** Edit `lua/keymaps.lua`
```lua
vim.g.mapleader = ","  -- Change to your preference
```

**Add new keymap:** Edit `lua/keymaps.lua`
```lua
vim.keymap.set("n", "<leader>x", ":YourCommand<CR>", { desc = "Description" })
```

**Add new plugin:** Create `lua/plugins/your-plugin.lua`
```lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  config = function()
    require("plugin-name").setup({})
  end
}
```

**Add LSP server:** Edit `lua/plugins/local/mason-tools/init.lua`

---

## 🐛 Troubleshooting

### Plugins not loading
```vim
:Lazy sync
:Lazy update
```

### LSP not working
```vim
:LspInfo
:Mason
:checkhealth lsp
```

### Slow startup
```bash
nvim --startuptime startup.log
tail -20 startup.log
```

### Check general health
```vim
:checkhealth
```

---

## 📈 Performance

### Optimizations Applied
- ✅ `vim.loader.enable()` - Module caching
- ✅ Lazy loading - All plugins load on-demand
- ✅ Native features - Faster than plugin alternatives
- ✅ Minimal dependencies - Only essential plugins
- ✅ Filetype-specific loading - Plugins load only when needed

### Benchmark Results
```
Startup Time: ~60-90ms (measured with --startuptime)
Plugin Count: 31 (lean)
Memory Usage: ~50MB at startup
LSP Attach Time: <100ms
```

---

## 🔄 Updates

### Keep Config Updated
```vim
# Update plugins
:Lazy update

# Update Treesitter parsers
:TSUpdate

# Update LSP servers
:Mason
```

### Stay Informed
- Check [Neovim releases](https://github.com/neovim/neovim/releases)
- Watch plugin changelogs
- Review deprecation warnings

---

## 🙏 Credits

Built with modern Neovim features and carefully selected plugins:

**Core:**
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configs

**Editing:**
- [mini.comment](https://github.com/echasnovski/mini.comment) - Commenting
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Surround
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax

**Navigation:**
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) - File explorer

**Language:**
- [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) - TypeScript
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Rust

**UI:**
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keymap helper
- [dressing.nvim](https://github.com/stevearc/dressing.nvim) - Better UI
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line

---

## 📝 License

This configuration is free to use, modify, and distribute.

---

## 🤝 Contributing

This is a personal configuration, but feel free to:
- Open issues for bugs or suggestions
- Submit PRs for improvements
- Use it as inspiration for your own config

---

**Last Updated:** 2024  
**Maintained:** Active  
**Support:** Neovim 0.11.4+

**Happy Coding! 🚀**
