# Plugin Removal Guide

This guide shows which plugins can be removed now that we're using native Neovim features.

## ✅ Already Removed

These plugins have been removed from the configuration:

### 1. vim-vsnip & cmp-vsnip
- **Replaced by**: `vim.snippet` (native in Neovim 0.10+)
- **Files modified**: `lua/plugins/nvim-cmp.lua`
- **Status**: ✅ Removed

## 🔧 Can Be Optionally Removed

### 2. nvim-cmp (and all cmp-* sources)
- **Replaced by**: `vim.lsp.completion` (native in Neovim 0.11+)
- **Current status**: Still enabled for enhanced features
- **To remove**:
  1. Delete or comment out `lua/plugins/nvim-cmp.lua`
  2. Optionally use `lua/native-completion.lua` for enhanced keymaps
  3. Native completion is already enabled in `nvim-lspconfig.lua`

**Plugins that would be removed**:
- `hrsh7th/nvim-cmp`
- `hrsh7th/cmp-nvim-lsp`
- `hrsh7th/cmp-nvim-lua`
- `hrsh7th/cmp-nvim-lsp-signature-help`
- `hrsh7th/cmp-buffer`
- `hrsh7th/cmp-path`
- `hrsh7th/cmp-cmdline`
- `onsails/lspkind.nvim`

**Trade-offs**:
- ✅ Simpler config, fewer dependencies, faster startup
- ❌ Fewer completion sources, less customization
- ❌ No buffer/path completion in command mode
- ❌ No fancy icons/formatting

### 3. nvim-lspconfig (partially optional)
- **Replaced by**: `vim.lsp.config()` and `vim.lsp.enable()` (native in Neovim 0.11+)
- **Current status**: Still used for plugin dependency declarations
- **Recommendation**: Keep it - provides sensible defaults and configurations

**Why keep it**:
- Provides pre-configured settings for many language servers
- Well-maintained defaults
- Easy to use
- Minimal overhead

### 4. lspkind.nvim
- **Purpose**: Adds icons to completion items
- **Current status**: Used by nvim-cmp
- **If removing nvim-cmp**: This can also be removed

## 📦 Plugins to Keep

These plugins provide functionality not available natively:

### Essential LSP Helpers
- **fidget.nvim**: LSP progress notifications (no native alternative)
- **mason.nvim**: Easy LSP/formatter/linter installation
- **mason-tool-installer.nvim**: Auto-install tools

### Git Integration
- **gitsigns.nvim**: Git signs, hunks, blame (no native alternative)

### Formatting & Linting
- **conform.nvim**: Multiple formatter support (simpler than manual setup)
- **nvim-lint.nvim**: Linting integration (no native alternative)

### UI & Navigation
- **telescope.nvim**: Fuzzy finder (no native alternative)
- **nvim-tree.nvim**: File explorer (netrw exists but this is better)
- **lualine.nvim**: Statusline (no native alternative)
- **barbar.nvim**: Buffer tabs (no native alternative)

### Editing
- **nvim-treesitter**: Better syntax highlighting (partially native in 0.11+)
- **nvim-autopairs**: Auto-close pairs
- **vim-surround**: Surround text objects
- **refactoring.nvim**: Refactoring operations

### Other
- **which-key.nvim**: Keymap hints
- **todo-comments.nvim**: Highlight TODO comments
- **copilot.lua**: GitHub Copilot integration

## 📊 Summary

### Minimal Native-Only Setup

If you want the most minimal setup using only native features:

```lua
-- Remove these plugin files:
-- - lua/plugins/nvim-cmp.lua
-- - lua/plugins/lspkind.nvim (if exists)

-- Keep these for essential LSP:
-- - lua/plugins/nvim-lspconfig.lua (already uses native APIs)
-- - lua/plugins/mason.nvim (for installing LSP servers)
-- - lua/plugins/fidget.nvim (for progress notifications)
```

### Recommended Setup (Current)

Keep nvim-cmp for better UX while using native features where possible:

- ✅ Native LSP config (`vim.lsp.config/enable`)
- ✅ Native snippets (`vim.snippet`)
- ✅ Native diagnostics (`vim.diagnostic`)
- ✅ Native inlay hints (`vim.lsp.inlay_hint`)
- ✅ Native completion (enabled alongside nvim-cmp)
- ✅ nvim-cmp (for enhanced completion features)

## 🚀 Quick Start Guides

### Option A: Use Current Setup (Recommended)
Everything is already configured! You're using:
- Native features where possible
- nvim-cmp for enhanced completion
- No vsnip (using native snippets)

### Option B: Remove nvim-cmp (Minimal)
```bash
# 1. Disable nvim-cmp
mv lua/plugins/nvim-cmp.lua lua/plugins/nvim-cmp.lua.disabled

# 2. Use native completion (already enabled in nvim-lspconfig.lua)
# 3. Optionally add enhanced keymaps from lua/native-completion.lua
```

## 📝 Testing

After any changes, test with:

```bash
# 1. Start Neovim
nvim

# 2. Check for errors
:checkhealth

# 3. Test LSP
:LspInfo

# 4. Test completion
# Open a file and type, press <C-Space> or <C-x><C-o>

# 5. Test snippets
# Trigger a completion with snippet, use <C-f> and <C-b> to navigate
```

## 🔄 Rollback

If you removed plugins and want them back:

```bash
# Restore nvim-cmp
mv lua/plugins/nvim-cmp.lua.disabled lua/plugins/nvim-cmp.lua

# Sync plugins
nvim +Lazy sync +qa
```

---

**Current Status**: Using maximum native features while keeping nvim-cmp for enhanced UX ✅
