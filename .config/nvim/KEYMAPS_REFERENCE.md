# Quick Reference: Native Features Keymaps

## Snippet Navigation (Native vim.snippet)

| Key | Mode | Action |
|-----|------|--------|
| `<C-f>` | Insert, Select | Jump to next snippet placeholder |
| `<C-b>` | Insert, Select | Jump to previous snippet placeholder |

## Completion (Native vim.lsp.completion + nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | Insert | Trigger LSP completion |
| `<C-n>` | Insert | Next completion item |
| `<C-p>` | Insert | Previous completion item |
| `<Tab>` | Insert | Next completion item (nvim-cmp) |
| `<S-Tab>` | Insert | Previous completion item (nvim-cmp) |
| `<CR>` | Insert | Confirm completion (nvim-cmp) |
| `<C-e>` | Insert | Close completion menu (nvim-cmp) |
| `<C-d>` | Insert | Scroll docs down (nvim-cmp) |
| `<C-u>` | Insert | Scroll docs up (nvim-cmp) |

## LSP Features (Native vim.lsp)

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gdv` | Normal | Go to definition (vertical split) |
| `gDv` | Normal | Go to declaration (vertical split) |
| `grr` | Normal | List references (Telescope) |
| `gri` | Normal | List implementations (Telescope) |
| `gO` | Normal | List document symbols (Telescope) |
| `grn` | Normal | Rename symbol |
| `gra` | Normal | Code actions |
| `<leader>o` | Normal | Organize imports (TS/JS) |
| `K` | Normal | Show hover documentation |
| `<leader>k` | Normal | Show signature help |
| `<leader>h` | Normal | Toggle inlay hints |
| `[e` | Normal | Previous error |
| `]e` | Normal | Next error |
| `[w` | Normal | Previous warning |
| `]w` | Normal | Next warning |

## Native Features Used

### ✅ Enabled Native Features
- `vim.snippet` - Snippet expansion and navigation
- `vim.lsp.completion` - LSP-based completion
- `vim.lsp.config/enable` - LSP server configuration
- `vim.lsp.inlay_hint` - Inlay hints display
- `vim.diagnostic.config` - Diagnostic configuration
- `vim.bo` - Modern buffer options

### 📦 Plugins Still Used
- `nvim-cmp` - Enhanced completion (can be removed)
- `fidget.nvim` - LSP progress notifications
- `telescope.nvim` - Fuzzy finder
- `mason.nvim` - Tool installer
- `gitsigns.nvim` - Git integration

### ❌ Plugins Removed
- `vim-vsnip` - Replaced by `vim.snippet`
- `cmp-vsnip` - Replaced by `vim.snippet`

## Quick Tips

1. **Trigger completion manually**: `<C-Space>` or `<C-x><C-o>`
2. **Navigate snippets**: Use `<C-f>` (forward) and `<C-b>` (backward)
3. **Toggle inlay hints**: `<leader>h` to show/hide type hints
4. **Check LSP status**: `:LspInfo`
5. **Check health**: `:checkhealth`

## For Native-Only Completion

If you remove nvim-cmp, these keymaps work with native completion:

| Key | Mode | Action |
|-----|------|--------|
| `<C-x><C-o>` | Insert | Trigger omnifunc completion |
| `<C-Space>` | Insert | Trigger completion (custom map) |
| `<C-n>` | Insert | Next item |
| `<C-p>` | Insert | Previous item |
| `<C-y>` | Insert | Accept completion |
| `<C-e>` | Insert | Close completion menu |

See `lua/native-completion.lua` for enhanced native-only keymaps.

---

**Version**: Neovim 0.11.3
**Last Updated**: 2025
