# LSP Commands Reference

This document describes the custom LSP commands implemented using Neovim 0.11+'s native `vim.lsp.config` and `vim.lsp.enable` APIs.

## Overview

These commands replace functionality that was previously provided by `nvim-lspconfig` plugin commands. They work natively with Neovim 0.11+ without requiring any plugins.

## Available Commands

### `:LspInfo`

**Description:** Display comprehensive information about LSP clients attached to the current buffer.

**Usage:**
```vim
:LspInfo
```

**Features:**
- Shows all attached LSP clients for the current buffer
- Displays client capabilities (completion, hover, formatting, etc.)
- Lists all configured LSP servers and their attachment status
- Opens in a split window with `q` to close

**Example Output:**
```
LSP Client Information
======================

Buffer: /path/to/file.ts
Filetype: typescript

Attached Clients (2):

Client #1:
  Name: ts_ls
  ID: 1
  Root Dir: /path/to/project
  Capabilities:
    ✓ Completion
    ✓ Hover
    ✓ Signature Help
    ✓ Go to Definition
    ✓ Find References
    ✓ Formatting
    ✓ Rename
    ✓ Code Actions
    ✓ Document Highlight

Client #2:
  Name: biome
  ID: 2
  Root Dir: /path/to/project
  Capabilities:
    ✓ Formatting
    ✓ Code Actions

Configured LSP Servers:
  ✓ ts_ls
  ✓ biome
  ○ lua_ls
  ○ rust_analyzer
```

---

### `:LspLog`

**Description:** Open the LSP log file in a split window for debugging LSP issues.

**Usage:**
```vim
:LspLog
```

**Features:**
- Opens the LSP log file (typically `~/.local/state/nvim/lsp.log`)
- Opens in read-only mode
- Automatically jumps to the end of the file (most recent logs)
- Press `q` to close the log window
- No word wrapping for easier log reading

**Use Cases:**
- Debugging LSP connection issues
- Investigating formatting or completion problems
- Checking LSP server errors and warnings
- Monitoring LSP communication

**Tip:** You can set the LSP log level with:
```lua
vim.lsp.set_log_level("debug")  -- Options: "trace", "debug", "info", "warn", "error", "off"
```

---

### `:LspRestart`

**Description:** Restart all LSP clients attached to the current buffer.

**Usage:**
```vim
:LspRestart
```

**Features:**
- Stops all LSP clients attached to the current buffer
- Automatically re-enables the servers after a short delay
- Useful when LSP becomes unresponsive or after configuration changes
- Shows notifications for each client being restarted

**When to Use:**
- LSP becomes unresponsive
- After changing LSP configuration
- When import organization stops working
- After installing new LSP dependencies

---

### `:Format`

**Description:** Manually format the current buffer using attached LSP servers.

**Usage:**
```vim
:Format
```

**Features:**
- Uses native `vim.lsp.buf.format()`
- Synchronous formatting (waits for completion)
- Uses all attached formatters (Biome for JS/TS, etc.)

**Related:** See `:FormatEnable` and `:FormatDisable` below.

---

### `:FormatEnable`

**Description:** Enable automatic formatting on save.

**Usage:**
```vim
:FormatEnable
```

**Features:**
- Re-enables both global and buffer-local auto-format
- Formatting will run automatically when saving files
- For TS/JS files, also organizes imports before formatting

---

### `:FormatDisable`

**Description:** Disable automatic formatting on save.

**Usage:**
```vim
" Disable globally
:FormatDisable

" Disable for current buffer only
:FormatDisable!
```

**Features:**
- Without `!`: Disables auto-format globally for all buffers
- With `!`: Disables auto-format only for the current buffer
- Useful when working with poorly formatted files
- Manual formatting with `:Format` still works

---

## Implementation Details

### Native Neovim 0.11+ Features Used

These commands are built entirely on native Neovim 0.11+ features:

- `vim.lsp.config()` - Configure LSP servers (replaces `lspconfig.setup()`)
- `vim.lsp.enable()` - Enable LSP servers (replaces `lspconfig.<server>.setup()`)
- `vim.lsp.get_clients()` - Get active LSP clients
- `vim.lsp.get_log_path()` - Get LSP log file path
- `vim.lsp.stop_client()` - Stop LSP clients
- `vim.lsp.buf.format()` - Format buffer using LSP

### No Plugins Required

These commands do **NOT** require:
- ❌ `nvim-lspconfig` (deprecated in Neovim 0.11+)
- ❌ Any additional LSP management plugins
- ✅ Only use native Neovim APIs

### Source Code Location

All commands are defined in:
```
lua/plugins/lsp.lua
```

In the `setup()` function, search for `vim.api.nvim_create_user_command`.

---

## Comparison with nvim-lspconfig

| Old (nvim-lspconfig) | New (Native) | Notes |
|---------------------|--------------|-------|
| `:LspInfo` | `:LspInfo` | Custom implementation, similar functionality |
| `:LspLog` | `:LspLog` | Custom implementation, opens in split |
| `:LspRestart` | `:LspRestart` | Custom implementation, restarts all clients |
| `:LspStart` | Not needed | Servers auto-start with `vim.lsp.enable()` |
| `:LspStop` | Not needed | Use `:LspRestart` instead |
| `require('lspconfig')` | `vim.lsp.config()` | Native API |
| `lspconfig.<server>.setup()` | `vim.lsp.enable()` | Native API |

---

## Troubleshooting

### LspInfo shows no clients

**Possible causes:**
1. LSP server not installed via Mason
2. File type not configured for LSP
3. LSP server failed to start

**Solutions:**
1. Check `:Mason` to ensure server is installed
2. Run `:LspLog` to check for errors
3. Verify server configuration in `lua/plugins/local/mason-tools/init.lua`

### LspLog shows errors

**Common errors:**

1. **"Server not found"**: Install server via `:Mason`
2. **"Root dir not found"**: Open file in a project directory
3. **"Permission denied"**: Check file/directory permissions
4. **Configuration errors**: Check server settings in mason-tools

### LspRestart doesn't fix issues

**Try:**
1. Completely quit and restart Neovim
2. Run `:checkhealth lsp` to diagnose issues
3. Clear LSP cache: `rm -rf ~/.local/state/nvim/lsp`
4. Reinstall LSP server in Mason

---

## See Also

- [KEYMAPS.md](KEYMAPS.md) - Complete keymap reference including LSP keybindings
- [LSP_MIGRATION.md](LSP_MIGRATION.md) - Migration guide from nvim-lspconfig
- `:help vim.lsp` - Native LSP documentation
- `:help vim.lsp.config` - LSP configuration help
- `:help vim.lsp.enable` - LSP enable help

---

**Last Updated:** 2024
**Neovim Version:** 0.11.4+
