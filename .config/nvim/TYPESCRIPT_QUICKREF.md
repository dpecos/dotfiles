# TypeScript/JavaScript Quick Reference

## LSP Server
- **Server:** `typescript-language-server` (ts_ls)
- **Version:** 5.0.1
- **Install:** Auto-installed via Mason
- **Config:** Native `vim.lsp.config` (Neovim 0.11+)

## Import Management

### Automatic (On Save)
When you save a TS/JS file:
1. Imports are organized (sorted, unused removed)
2. Code is formatted with Biome

### Manual Commands

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>oi` | Organize imports | Sort and remove unused |
| `<leader>os` | Sort imports | Sort only |
| `<leader>ou` | Remove unused | Remove unused imports |
| `<leader>oa` | Add missing | Add missing imports |
| `<leader>of` | Fix all | Fix all fixable errors |

## Standard LSP Features

| Keymap | Feature |
|--------|---------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>k` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer |

## Diagnostics

| Keymap | Feature |
|--------|---------|
| `]e` | Next error |
| `[e` | Previous error |
| `]w` | Next warning |
| `[w` | Previous warning |

## Inlay Hints

| Keymap | Feature |
|--------|---------|
| `<leader>h` | Toggle inlay hints |

**Enabled by default:**
- Parameter names
- Variable types
- Function return types
- Property types
- Enum values

## Configuration Files

- **LSP Config:** `lua/plugins/local/mason-tools/init.lua`
- **Keymaps:** `lua/plugins/typescript-tools.lua`
- **Format on save:** `lua/plugins/lsp.lua`

## Formatting & Linting

- **Formatter:** Biome LSP
- **Config:** `biome.json` in project root
- **On save:** Automatic
- **Manual:** `<leader>f`

## Troubleshooting

### Check LSP Status
```vim
:LspInfo
```
Should show `ts_ls` attached.

### Check Server Installation
```bash
~/.local/share/nvim/mason/bin/typescript-language-server --version
```

### Reinstall Server
```vim
:MasonUninstall typescript-language-server
:MasonInstall typescript-language-server
```

### Check Logs
```vim
:lua vim.cmd('edit ' .. vim.lsp.get_log_path())
```

## Tips

1. **Import completion:** Type and use `<C-n>` or `<C-x><C-o>` for auto-import
2. **Organize imports:** Don't worry about import order - save does it automatically
3. **Quick fixes:** Use `<leader>ca` for code actions (auto-import, quick fixes)
4. **Type info:** Hover over symbols with `K` for type information
5. **Inlay hints:** Toggle with `<leader>h` if they're distracting

## Native APIs Used

- `vim.lsp.config()` - Configure LSP server
- `vim.lsp.enable()` - Enable LSP server  
- `vim.lsp.buf.execute_command()` - Execute LSP commands
- `vim.lsp.buf.code_action()` - Trigger code actions
- `vim.lsp.buf.format()` - Format buffer
- `vim.lsp.inlay_hint.enable()` - Toggle inlay hints
- `vim.lsp.completion.enable()` - Enable completion

No plugins needed! 🎉
