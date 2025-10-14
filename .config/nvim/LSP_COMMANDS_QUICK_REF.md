# LSP Commands - Quick Reference

## Commands

| Command | Description | When to Use |
|---------|-------------|-------------|
| `:LspInfo` | Show LSP client info & capabilities | Check which servers are attached |
| `:LspLog` | Open LSP log file | Debug LSP issues |
| `:LspRestart` | Restart all LSP clients | Fix unresponsive LSP |
| `:Format` | Format current buffer | Manual formatting |
| `:FormatEnable` | Enable auto-format on save | Re-enable after disabling |
| `:FormatDisable` | Disable auto-format (global) | Working with badly formatted files |
| `:FormatDisable!` | Disable auto-format (buffer) | Disable for current file only |

## Quick Examples

### Check LSP Status
```vim
:LspInfo
" Press 'q' to close
```

### Debug LSP Issues
```vim
:LspLog
" Jumps to end of log
" Press 'q' to close
```

### Restart Stuck LSP
```vim
:LspRestart
" Restarts all attached clients
```

### Format File
```vim
:Format
" For TS/JS: organizes imports + formats
```

### Temporarily Disable Auto-Format
```vim
:FormatDisable!
" Edit file without auto-formatting
:FormatEnable
" Re-enable when done
```

## Troubleshooting

### No clients attached?
1. `:LspInfo` - Check if server configured
2. `:Mason` - Ensure server installed
3. `:LspLog` - Check for errors

### LSP not working?
1. `:LspRestart` - Try restarting
2. `:LspLog` - Check logs
3. `:checkhealth lsp` - Diagnose issues

### Formatting not working?
1. `:LspInfo` - Check if server has formatting capability
2. `:FormatEnable` - Ensure not disabled
3. `:LspLog` - Check for format errors

## Key Features

### LspInfo
- ✓ Shows all attached clients
- ✓ Lists capabilities per client
- ✓ Shows configured servers
- ✓ Visual indicators (✓/○)
- ✓ Press 'q' to close

### LspLog
- ✓ Opens in split window
- ✓ Read-only mode
- ✓ Jumps to recent logs
- ✓ No word wrap
- ✓ Press 'q' to close

### LspRestart
- ✓ Stops all clients
- ✓ Auto re-enables
- ✓ Shows notifications
- ✓ Safe for any buffer

## See Full Documentation

- [LSP_COMMANDS.md](LSP_COMMANDS.md) - Complete reference
- [KEYMAPS.md](KEYMAPS.md) - All keymaps
- `:help vim.lsp` - Neovim LSP help

---

**Tip:** Use `:Telescope commands` to find all available commands!
