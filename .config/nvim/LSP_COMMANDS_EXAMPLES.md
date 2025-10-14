# LSP Commands - Example Outputs

This document shows example outputs from each LSP command to help you understand what to expect.

## :LspInfo

**Example output when editing a TypeScript file:**

```
LSP Client Information
======================

Buffer: /path/to/project/src/index.ts
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
    ✓ Go to Declaration
    ✓ Find References
    ✓ Rename
    ✓ Code Actions
    ✓ Document Highlight
    ✓ Inlay Hints

Client #2:
  Name: biome
  ID: 2
  Root Dir: /path/to/project
  Capabilities:
    ✓ Formatting
    ✓ Range Formatting
    ✓ Code Actions

Configured LSP Servers:
  ✓ ts_ls
  ✓ biome
  ○ lua_ls
  ○ rust_analyzer
  ○ gopls
```

**Legend:**
- ✓ = Server is attached to current buffer
- ○ = Server is configured but not attached (wrong filetype or not in project)

---

**Example output when editing a Lua file:**

```
LSP Client Information
======================

Buffer: /Users/user/.config/nvim/lua/plugins/lsp.lua
Filetype: lua

Attached Clients (1):

Client #1:
  Name: lua_ls
  ID: 3
  Root Dir: /Users/user/.config/nvim
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
    ✓ Inlay Hints

Configured LSP Servers:
  ○ ts_ls
  ○ biome
  ✓ lua_ls
  ○ rust_analyzer
```

---

**Example output when no LSP clients attached:**

```
No LSP clients attached to this buffer
```

This happens when:
- File type is not supported by any configured LSP server
- LSP server failed to start
- File is outside of any project directory

**Solution:** Check `:Mason` to ensure the appropriate server is installed.

---

## :LspLog

**Example log file content (end of file):**

```
[START][2024-01-15 10:30:45] LSP logging initiated
[INFO][2024-01-15 10:30:46] ts_ls: Starting server
[DEBUG][2024-01-15 10:30:46] ts_ls: cmd = { "typescript-language-server", "--stdio" }
[INFO][2024-01-15 10:30:47] ts_ls: Server started
[DEBUG][2024-01-15 10:30:47] ts_ls: root_dir = /path/to/project
[INFO][2024-01-15 10:30:48] ts_ls: Client initialized
[DEBUG][2024-01-15 10:30:48] ts_ls: Capabilities registered
[INFO][2024-01-15 10:31:15] biome: Starting server
[DEBUG][2024-01-15 10:31:15] biome: cmd = { "biome", "lsp-proxy" }
[INFO][2024-01-15 10:31:16] biome: Server started
[DEBUG][2024-01-15 10:31:30] ts_ls: textDocument/formatting requested
[DEBUG][2024-01-15 10:31:31] biome: textDocument/formatting requested
[INFO][2024-01-15 10:31:31] Document formatted successfully
```

**When opened:**
- File opens in a horizontal split
- Read-only mode (can't accidentally edit)
- Automatically jumps to the end (most recent logs)
- No word wrap (easier to read long lines)
- Press `q` to close the window

**Common log entries to look for:**

- `[ERROR]` - Something went wrong (LSP server crash, config error, etc.)
- `[WARN]` - Potential issues (deprecated features, slow responses, etc.)
- `[INFO]` - Normal operations (server start, formatting, etc.)
- `[DEBUG]` - Detailed information (for debugging)

**Example error in log:**

```
[ERROR][2024-01-15 10:45:12] ts_ls: Server crashed
[ERROR][2024-01-15 10:45:12] ts_ls: Error: ENOENT: no such file or directory
[ERROR][2024-01-15 10:45:12] ts_ls: Check that typescript-language-server is installed
```

---

## :LspRestart

**Example output:**

```
Restarting ts_ls...
Restarting biome...
LSP clients restarted
```

**What happens:**
1. Shows notification for each client being stopped
2. Waits 500ms
3. Re-enables all configured LSP servers
4. Shows success notification
5. Clients will reattach automatically

**When no clients attached:**

```
No LSP clients attached to this buffer
```

---

## :Format

**Successful format:**
- No output (file is formatted silently)
- File is updated in buffer
- For TS/JS files: imports are organized first, then formatted

**If formatting disabled:**
- No output (respects `:FormatDisable` setting)

**If no formatter available:**
```
No formatter available for this buffer
```

---

## :FormatEnable / :FormatDisable

**:FormatEnable:**
```
Auto-formatting enabled
```

**:FormatDisable:**
```
Auto-formatting disabled (global)
```

**:FormatDisable!:**
```
Auto-formatting disabled (buffer)
```

---

## Real-World Usage Examples

### Example 1: Debugging TypeScript LSP Issues

```vim
" Open a TypeScript file
:e src/app.ts

" Check if ts_ls is attached
:LspInfo
" Output shows ts_ls attached with all capabilities

" Something seems wrong, check the logs
:LspLog
" Press 'G' to jump to end if not already there
" Look for [ERROR] or [WARN] entries
" Press 'q' to close

" If needed, restart LSP
:LspRestart
" Should see: Restarting ts_ls... LSP clients restarted
```

### Example 2: Checking Formatter Capabilities

```vim
" Open file
:e src/index.ts

" Check which client provides formatting
:LspInfo
" Look for "✓ Formatting" under each client
" Should see it under "biome"

" Manually format
:Format
" File is formatted + imports organized
```

### Example 3: Temporarily Disabling Auto-Format

```vim
" Working with a badly formatted file
:e legacy-code.js

" Disable auto-format for this buffer only
:FormatDisable!
" Output: Auto-formatting disabled (buffer)

" Make changes without auto-formatting on save
" ... edit file ...

" Re-enable when done
:FormatEnable
" Output: Auto-formatting enabled
```

### Example 4: Investigating Why LSP Won't Attach

```vim
" Open file
:e random-script.sh

" Check LSP status
:LspInfo
" Output: No LSP clients attached to this buffer

" Check what servers are configured
" (LspInfo shows configured servers even when not attached)
" Configured LSP Servers:
"   ○ ts_ls
"   ○ biome
"   ○ lua_ls
"   ○ rust_analyzer
"   ○ bash-language-server  <-- This should handle .sh files

" Check if bash-language-server is installed
:Mason
" Search for "bash-language-server"
" If not installed, install it

" Check logs for why it didn't start
:LspLog
" Look for error messages

" After fixing, restart
:LspRestart
```

---

## Tips & Tricks

### Tip 1: Use LspInfo to Verify Configuration

After changing LSP settings, use `:LspInfo` to verify:
- Server is attached
- Capabilities are correct
- Root directory is detected properly

### Tip 2: Monitor LSP Log in Real-Time

Open log in split and watch for issues:
```vim
:LspLog
:wincmd p  " Switch back to your file
" Keep log visible while working
```

### Tip 3: Quick Diagnostic Workflow

When LSP isn't working:
```vim
:LspInfo     " Check status
:LspLog      " Check errors
:LspRestart  " Try restart
```

### Tip 4: Format-on-Save Toggle

Create quick toggle for auto-format:
```vim
" In your config, map to key:
vim.keymap.set('n', '<leader>tf', function()
  if vim.b.disable_autoformat or vim.g.disable_autoformat then
    vim.cmd('FormatEnable')
  else
    vim.cmd('FormatDisable!')
  end
end, { desc = 'Toggle auto-format' })
```

---

## See Also

- [LSP_COMMANDS.md](LSP_COMMANDS.md) - Complete command reference
- [LSP_COMMANDS_QUICK_REF.md](LSP_COMMANDS_QUICK_REF.md) - Quick reference
- [KEYMAPS.md](KEYMAPS.md) - All keymaps
- `:help vim.lsp` - Neovim LSP help

---

**Last Updated:** 2024
**Neovim Version:** 0.11.4+
