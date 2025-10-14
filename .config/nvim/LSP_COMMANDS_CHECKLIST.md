# LSP Commands - Testing Checklist

Use this checklist to verify that the new LSP commands are working correctly.

## Pre-Testing

- [ ] Neovim version is 0.11.0 or higher (`:version`)
- [ ] Configuration loads without errors
- [ ] At least one LSP server is installed via Mason (`:Mason`)

## Command Testing

### :LspInfo

- [ ] Command exists (`:LspInfo` doesn't show "Not an editor command")
- [ ] Opens in a split window when run
- [ ] Shows buffer information (path and filetype)
- [ ] Lists attached clients (if any)
- [ ] Shows client capabilities
- [ ] Lists configured LSP servers with status indicators
- [ ] Pressing `q` closes the window
- [ ] Works when no clients are attached (shows appropriate message)

**Test in:**
- [ ] TypeScript/JavaScript file (should show ts_ls and biome)
- [ ] Lua file (should show lua_ls)
- [ ] Rust file (should show rust_analyzer)
- [ ] Plain text file (should show no attached clients)

### :LspLog

- [ ] Command exists (`:LspLog` doesn't show "Not an editor command")
- [ ] Opens log file in split window
- [ ] Cursor is at the end of the file
- [ ] Buffer is read-only
- [ ] Word wrap is disabled
- [ ] Pressing `q` closes the window
- [ ] Shows notification if log file doesn't exist

**Verify:**
- [ ] Log file path is correct (typically `~/.local/state/nvim/lsp.log`)
- [ ] Can see recent LSP activity in the log
- [ ] Log shows server start/stop events
- [ ] Errors and warnings are visible

### :LspRestart

- [ ] Command exists (`:LspRestart` doesn't show "Not an editor command")
- [ ] Shows notification for each client being restarted
- [ ] Shows success notification after restart
- [ ] LSP clients reattach automatically after restart
- [ ] Works when no clients are attached (shows appropriate message)

**Verify:**
- [ ] LSP functionality works after restart (completion, hover, etc.)
- [ ] Run `:LspInfo` after restart to verify clients reattached
- [ ] Check `:LspLog` for restart events

### :Format

- [ ] Command exists (`:Format` doesn't show "Not an editor command")
- [ ] Formats the current buffer
- [ ] For TS/JS files: organizes imports before formatting
- [ ] Works synchronously (waits for completion)
- [ ] Respects `:FormatDisable` setting

**Test in:**
- [ ] TypeScript file with messy formatting
- [ ] JavaScript file with unorganized imports
- [ ] Lua file
- [ ] Any file with an attached formatter

### :FormatEnable / :FormatDisable

- [ ] `:FormatEnable` exists
- [ ] `:FormatDisable` exists
- [ ] `:FormatDisable!` works (buffer-local)
- [ ] Shows appropriate notification when toggling
- [ ] `:FormatDisable` prevents auto-format on save
- [ ] `:FormatEnable` re-enables auto-format on save
- [ ] `:FormatDisable!` only affects current buffer

**Verify:**
- [ ] After `:FormatDisable`, saving doesn't format
- [ ] After `:FormatEnable`, saving formats again
- [ ] `:FormatDisable!` in one buffer doesn't affect others

## Integration Testing

### With Native LSP

- [ ] Commands work with vim.lsp.config/enable approach
- [ ] No conflicts with native LSP functionality
- [ ] Works alongside existing LSP features (completion, hover, etc.)

### With Plugins

- [ ] No conflicts with Telescope
- [ ] No conflicts with Mason
- [ ] No conflicts with fidget.nvim
- [ ] No conflicts with other LSP-related plugins

### User Experience

- [ ] All commands have helpful descriptions (`:command` shows them)
- [ ] Error messages are clear and actionable
- [ ] Notifications are informative
- [ ] Windows can be closed easily with `q`
- [ ] No unexpected behavior

## Documentation Testing

- [ ] LSP_COMMANDS.md is complete and accurate
- [ ] LSP_COMMANDS_QUICK_REF.md is easy to use
- [ ] LSP_COMMANDS_EXAMPLES.md examples match actual output
- [ ] KEYMAPS.md includes LSP commands section
- [ ] All links in documentation work

## Real-World Scenarios

### Scenario 1: New TypeScript Project

1. [ ] Open a .ts file
2. [ ] Run `:LspInfo` - should show ts_ls and biome attached
3. [ ] Run `:Format` - file should be formatted
4. [ ] Make changes and save - should auto-format
5. [ ] Run `:FormatDisable!` - disable for this file
6. [ ] Save - should not auto-format
7. [ ] Run `:FormatEnable` - re-enable
8. [ ] Save - should auto-format again

### Scenario 2: Debugging LSP Issues

1. [ ] Open a file where LSP isn't working
2. [ ] Run `:LspInfo` - identify which servers should be attached
3. [ ] Run `:LspLog` - check for error messages
4. [ ] Run `:LspRestart` - attempt to fix
5. [ ] Run `:LspInfo` again - verify clients attached
6. [ ] Test LSP functionality (completion, hover, etc.)

### Scenario 3: Multiple Buffers

1. [ ] Open TypeScript file
2. [ ] Run `:LspInfo` - note attached clients
3. [ ] Open Lua file
4. [ ] Run `:LspInfo` - should show different clients
5. [ ] Switch back to TypeScript file
6. [ ] Run `:LspInfo` - should show original clients
7. [ ] Run `:LspRestart` - should only affect current buffer

## Performance Testing

- [ ] `:LspInfo` responds quickly (< 1 second)
- [ ] `:LspLog` opens instantly
- [ ] `:LspRestart` completes in reasonable time (< 2 seconds)
- [ ] No lag when running commands
- [ ] No memory leaks after repeated use

## Edge Cases

### Empty/New Files

- [ ] `:LspInfo` in new unsaved buffer
- [ ] `:Format` in empty file
- [ ] `:LspRestart` in new buffer

### Large Files

- [ ] `:LspInfo` in large file (1000+ lines)
- [ ] `:Format` in large file
- [ ] `:LspRestart` with multiple clients

### Special Characters

- [ ] Works with files containing special characters in path
- [ ] Works with Unicode in file content
- [ ] Works with files in nested directories

### Error Conditions

- [ ] LSP server not installed
- [ ] LSP server crashes during operation
- [ ] Log file doesn't exist
- [ ] No write permissions
- [ ] Network issues (if applicable)

## Regression Testing

After any changes to LSP configuration:

- [ ] All commands still work
- [ ] No new errors in `:messages`
- [ ] No errors when starting Neovim
- [ ] LSP functionality still works (completion, hover, etc.)

## Final Verification

- [ ] All commands are documented in KEYMAPS.md
- [ ] All commands have proper descriptions
- [ ] Commands follow Neovim conventions
- [ ] No deprecation warnings
- [ ] Ready for production use

## Notes

Use this space to record any issues or observations:

```
Date: ___________
Tester: ___________

Issues found:
-
-
-

Additional comments:
-
-
-
```

---

## Quick Test Script

Run this in Neovim to quickly test all commands:

```vim
" Test all LSP commands
:echo "Testing LSP commands..."

" Test LspInfo
:LspInfo
" Press 'q' to close

" Test LspLog
:LspLog
" Press 'q' to close

" Test Format
:Format

" Test FormatDisable/Enable
:FormatDisable!
:echo "Auto-format disabled"
:FormatEnable
:echo "Auto-format enabled"

" Test LspRestart
:LspRestart

" Final check
:LspInfo

:echo "All commands tested!"
```

---

**Status:** ⬜ Not Started | 🔄 In Progress | ✅ Complete | ❌ Failed

**Overall Status:** ___________

**Date Completed:** ___________

**Sign-off:** ___________
