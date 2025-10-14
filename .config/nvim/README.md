# Neovim Configuration

**Version:** Modern & Optimized
**Neovim:** 0.11.4+
**Philosophy:** Native-first, Performance-focused, Well-documented

---

## 🚀 Quick Start

### First Time Setup

1. **Open Neovim** - Plugins will auto-install on first launch
   ```bash
   nvim
   ```

2. **Sync plugins** (if needed)
   ```vim
   :Lazy sync
   ```

3. **Install LSP servers and tools**
   ```vim
   :Mason
   ```

4. **Check health**
   ```vim
   :checkhealth
   ```

### Test Your Setup

Try these commands to verify everything works:

```vim
" Open a file and test completion
<C-Space>       " Trigger LSP completion
<Tab>           " Navigate completions
<CR>            " Accept completion

" Test LSP features
gd              " Go to definition
K               " Show documentation
grn             " Rename symbol
gra             " Code actions

" Test file navigation
<leader>ff      " Find files
<leader>fg      " Live grep
<C-n>           " Toggle file tree

" Test editing
gcc             " Comment line
ysiw"           " Surround word with quotes
```

---

## 📚 Documentation

### Essential
- **[KEYMAPS_REFERENCE.md](KEYMAPS_REFERENCE.md)** - Complete keymap reference (100+ keymaps)

### Configuration Files
- `init.lua` - Entry point
- `lua/settings.lua` - Neovim options
- `lua/keymaps.lua` - General keymaps
- `lua/plugins/` - Plugin configurations

---

## ⌨️ Key Bindings

**Leader key:** `<Space>`

### Most Used Commands

| Action | Keymap | Description |
|--------|--------|-------------|
| Comment line | `gcc` | Toggle comment |
| Find files | `<leader>ff` | Fuzzy find files |
| Live grep | `<leader>fg` | Search in files |
| File tree | `<C-n>` or `<leader>ee` | Toggle file explorer |
| Go to definition | `gd` | Jump to definition |
| Code action | `gra` | Show code actions |
| Rename | `grn` | Rename symbol |
| Format | `<leader>f` | Format buffer |
| Show keymaps | `<leader>` + wait | Which-key popup |
| Next buffer | `<A-.>` | Next buffer |
| Previous buffer | `<A-,>` | Previous buffer |

**Full reference:** See [KEYMAPS_REFERENCE.md](KEYMAPS_REFERENCE.md)

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

## 🔧 Customization

### File Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── settings.lua         # Neovim options & completion
│   ├── keymaps.lua          # General keymaps
│   ├── plugins-bootstrap.lua # Lazy.nvim setup
│   └── plugins/             # Plugin configurations
│       ├── lsp.lua              # LSP setup
│       ├── typescript-tools.lua # TypeScript
│       ├── rustaceanvim.lua     # Rust
│       ├── telescope.lua        # Fuzzy finder
│       ├── mini-comment.lua     # Commenting
│       ├── nvim-surround.lua    # Surround
│       ├── which-key.lua        # Keymap helper
│       └── ... (more plugins)
└── ftplugin/                # Filetype-specific settings
```

### Common Customizations

**Change leader key:**
Edit `lua/keymaps.lua`
```lua
vim.g.mapleader = ","  -- Default is <Space>
```

**Add new keymap:**
Edit `lua/keymaps.lua`
```lua
vim.keymap.set("n", "<leader>x", ":YourCommand<CR>", { desc = "Description" })
```

**Add new plugin:**
Create `lua/plugins/your-plugin.lua`
```lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  config = function()
    require("plugin-name").setup({})
  end
}
```

**Modify LSP settings:**
Edit `lua/plugins/lsp.lua`

**Add/Remove LSP servers:**
Edit `lua/plugins/lsp.lua` and update the `servers` table

---

## 🐛 Troubleshooting

### Plugins not loading
```vim
:Lazy sync
:Lazy update
```

### LSP not working
```vim
:LspInfo          " Check attached LSP servers
:Mason            " Install/update LSP servers
:checkhealth lsp  " Check LSP health
```

### Slow startup
```bash
nvim --startuptime startup.log
tail -20 startup.log
```

### General issues
```vim
:checkhealth      " Check overall health
```

---

## 📈 Performance

### Stats
- **Startup Time:** ~60-90ms (very fast)
- **Plugin Count:** ~31 (essential only)
- **Memory Usage:** ~50MB at startup
- **LSP Attach Time:** <100ms

### Optimizations Applied
- ✅ `vim.loader.enable()` - Module caching for faster startup
- ✅ Lazy loading - Plugins load on-demand
- ✅ Native features - Using Neovim built-ins over plugins
- ✅ Minimal dependencies - Only essential plugins
- ✅ Filetype-specific loading - Plugins load when needed

---

## 🔄 Updates

### Keep Config Updated

```vim
" Update plugins
:Lazy update

" Update Treesitter parsers
:TSUpdate

" Update LSP servers and tools
:Mason
```

### Stay Informed
- Check [Neovim releases](https://github.com/neovim/neovim/releases)
- Review plugin changelogs
- Monitor deprecation warnings

---

## 🎯 TypeScript/JavaScript Import Management

Imports are automatically organized on save for TS/JS files:
- **Sorted alphabetically** - Clean and consistent
- **Unused imports removed** - No clutter
- **Via native LSP** - Fast and reliable

Manual commands available:
```vim
<leader>oi    " Organize imports (sort + remove unused)
<leader>os    " Sort imports only
<leader>ou    " Remove unused imports only
<leader>oa    " Add missing imports
<leader>of    " Fix all fixable errors
```

Powered by `typescript-tools.nvim` using native TypeScript language server.

---

## 🦀 Rust Development

Special features for Rust files:

### Keymaps (in .rs files)
```vim
<leader>rr    " Run runnables (cargo run, test, bench)
<leader>rt    " Run testables
<leader>rd    " Run debuggables
<leader>re    " Expand macro
<leader>rc    " Open Cargo.toml
K             " Hover with actions
```

### Cargo.toml Management
When editing `Cargo.toml`:
```vim
<leader>ct    " Toggle crates UI
<leader>cu    " Update crate
<leader>cU    " Upgrade crate (major version)
<leader>cv    " Show available versions
<leader>cf    " Show features
<leader>cd    " Open documentation
```

Powered by `rustaceanvim` and `crates.nvim`.

---

## 🙏 Credits

Built with modern Neovim features and carefully selected plugins.

### Core Plugins

**Plugin Manager:**
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Fast plugin manager

**LSP & Language Tools:**
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) - Enhanced TypeScript/JavaScript
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Best-in-class Rust support
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/tool installer

**Editing:**
- [mini.comment](https://github.com/echasnovski/mini.comment) - Fast commenting
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Surround text objects
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-close pairs
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting

**Navigation:**
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [barbar.nvim](https://github.com/romgrk/barbar.nvim) - Buffer/tab management

**UI:**
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keymap helper
- [dressing.nvim](https://github.com/stevearc/dressing.nvim) - Better UI elements
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration

**Utilities:**
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Better folding
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight TODOs
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) - Search & replace

---

## 📝 License

This configuration is free to use, modify, and distribute.

---

**Last Updated:** 2025/10/14
**Neovim Version:** 0.11.4+
**Status:** Active & Maintained

**Happy Coding! 🚀**
