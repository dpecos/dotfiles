# Post-Migration Verification Checklist

## Immediate Verification

- [ ] 1. **Restart Neovim**
  ```bash
  nvim
  ```
  - Should start without errors
  - No deprecation warnings about nvim-lspconfig

- [ ] 2. **Check Health**
  ```vim
  :checkhealth vim.lsp
  ```
  - Should show no errors
  - Should list available LSP features

- [ ] 3. **Verify Plugin Sync**
  ```vim
  :Lazy sync
  ```
  - Should complete successfully
  - nvim-lspconfig should no longer be listed

## LSP Functionality Tests

### Lua Files
- [ ] 4. **Open a Lua file**
  ```bash
  nvim ~/.config/nvim/init.lua
  ```
  - [ ] LSP should attach automatically
  - [ ] Check with `:LspInfo` - should show lua_ls attached
  - [ ] Test completion: Type `vim.` and press `<C-n>` or `<Tab>`
  - [ ] Test hover: Put cursor on `vim` and press `K`
  - [ ] Test go-to-definition: Put cursor on a function and press `gd`
  - [ ] Test formatting: Press `<leader>f`

### TypeScript/JavaScript Files
- [ ] 5. **Open a TypeScript file**
  ```bash
  cd ~/your-ts-project
  nvim src/index.ts
  ```
  - [ ] LSP should attach (typescript-tools)
  - [ ] Check with `:LspInfo` - should show tsserver
  - [ ] Biome should also attach for formatting
  - [ ] Test completion
  - [ ] Test imports: Save file and verify imports are organized
  - [ ] Test formatting on save

### JSON Files
- [ ] 6. **Open a JSON file**
  ```bash
  nvim package.json
  ```
  - [ ] LSP should attach (jsonls or biome)
  - [ ] Test formatting

### Go Files (if you have Go projects)
- [ ] 7. **Open a Go file**
  ```bash
  nvim main.go
  ```
  - [ ] gopls should attach
  - [ ] Test completion
  - [ ] Test formatting

### Rust Files (if you have Rust projects)
- [ ] 8. **Open a Rust file**
  ```bash
  nvim src/main.rs
  ```
  - [ ] rust-analyzer should attach (via rustaceanvim)
  - [ ] No warnings about configuration conflicts
  - [ ] Test completion
  - [ ] Test inlay hints: `<leader>h` to toggle

## Feature Verification

### Completion
- [ ] 9. **Native completion works**
  - [ ] Trigger with `<C-Space>` or `<C-n>`
  - [ ] Navigate with `<Tab>` and `<S-Tab>`
  - [ ] Accept with `<CR>`
  - [ ] Close with `<C-e>`

### Diagnostics
- [ ] 10. **Diagnostics display correctly**
  - [ ] Inline diagnostics show by default
  - [ ] Toggle with `<leader>d` cycles through modes:
    - Virtual text (inline)
    - Virtual lines (below code)
    - Minimal (signs only)
  - [ ] Navigate errors: `]e` and `[e`
  - [ ] Navigate warnings: `]w` and `[w`

### Inlay Hints
- [ ] 11. **Inlay hints work** (where supported)
  - [ ] Enabled by default
  - [ ] Toggle with `<leader>h`
  - [ ] Visible in supported languages (Rust, TypeScript)

### Formatting
- [ ] 12. **Format on save works**
  - [ ] Modify a file and save
  - [ ] File should auto-format
  - [ ] For TS/JS: imports should also be organized
  - [ ] Disable with `:FormatDisable!` (buffer) or `:FormatDisable` (global)
  - [ ] Re-enable with `:FormatEnable`

### Keymaps
- [ ] 13. **All LSP keymaps work**
  - [ ] `gd` - Go to definition
  - [ ] `gdv` - Go to definition (vertical split)
  - [ ] `gD` - Go to declaration
  - [ ] `grr` - List references (Telescope)
  - [ ] `gri` - List implementations (Telescope)
  - [ ] `gO` - List document symbols (Telescope)
  - [ ] `grn` - Rename symbol
  - [ ] `gra` - Code actions
  - [ ] `K` - Show hover documentation
  - [ ] `<leader>k` - Show signature help
  - [ ] `<leader>f` - Format buffer

### TypeScript Specific
- [ ] 14. **TypeScript-tools keymaps work**
  - [ ] `<leader>oi` - Organize imports
  - [ ] `<leader>os` - Sort imports
  - [ ] `<leader>ou` - Remove unused imports
  - [ ] `<leader>oa` - Add missing imports
  - [ ] `<leader>of` - Fix all fixable errors
  - [ ] `gds` - Go to source definition
  - [ ] `grf` - File references
  - [ ] `<leader>rf` - Rename file & update imports

### Rust Specific
- [ ] 15. **Rustacean keymaps work**
  - [ ] `<leader>rr` - Runnables
  - [ ] `<leader>rt` - Testables
  - [ ] `<leader>rd` - Debuggables
  - [ ] `<leader>re` - Expand macro
  - [ ] `<leader>rc` - Open Cargo.toml

## Performance Checks

- [ ] 16. **Startup time** (optional)
  ```bash
  nvim --startuptime /tmp/startup.log +qa && tail -1 /tmp/startup.log
  ```
  - Should be fast (< 100ms ideally)
  - Compare with previous startup time if you recorded it

- [ ] 17. **LSP responsiveness**
  - [ ] Completion appears quickly (< 500ms)
  - [ ] Go to definition is instant
  - [ ] No noticeable lag when editing

## Error Checking

- [ ] 18. **No errors in logs**
  ```vim
  :messages
  ```
  - Should show no errors
  - No deprecation warnings

- [ ] 19. **Check LSP logs** (if needed)
  ```vim
  :LspLog
  ```
  - Should show LSP activity
  - No critical errors

## Documentation

- [ ] 20. **Documentation is accessible**
  - [ ] Read LSP_MIGRATION.md
  - [ ] Read NATIVE_LSP_REFERENCE.md
  - [ ] KEYMAPS.md is up to date

## Additional Checks

- [ ] 21. **Mason is working**
  ```vim
  :Mason
  ```
  - All tools installed
  - No missing dependencies

- [ ] 22. **No plugin conflicts**
  ```vim
  :Lazy
  ```
  - All plugins loaded successfully
  - No error badges on plugins

## Troubleshooting

If any test fails:

1. **Check LSP is attached**
   ```vim
   :LspInfo
   ```

2. **Check health**
   ```vim
   :checkhealth vim.lsp
   ```

3. **View logs**
   ```vim
   :LspLog
   :messages
   ```

4. **Verify server is installed**
   ```vim
   :Mason
   ```

5. **Check configuration**
   ```vim
   :lua print(vim.inspect(vim.lsp.get_clients()))
   ```

6. **Restart LSP**
   ```vim
   :LspRestart
   ```

## Success Criteria

✅ All LSP features work as before
✅ No deprecation warnings
✅ No errors in logs
✅ All keymaps functional
✅ Completion works
✅ Formatting works
✅ Diagnostics display correctly
✅ Performance is same or better

## Notes

- If you encounter any issues, refer to the troubleshooting section in LSP_MIGRATION.md
- The migration maintains 100% feature parity with the old configuration
- All native Neovim 0.11+ features are now being used
- No plugins needed for core LSP functionality

---

**Date Completed**: ________________
**Verified By**: ________________
**Status**: [ ] All tests passed  [ ] Issues found (see notes below)

**Notes**:
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
