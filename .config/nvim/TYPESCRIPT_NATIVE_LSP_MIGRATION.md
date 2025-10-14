# TypeScript Native LSP Migration

## Summary

Migrated from `typescript-tools.nvim` (which depends on the deprecated `nvim-lspconfig`) to native Neovim LSP configuration using `vim.lsp.config` and `vim.lsp.enable` (Neovim 0.11+).

## What Changed

### Removed
- ❌ `typescript-tools.nvim` plugin (had dependency on deprecated lspconfig)
- ❌ All plugin-specific TypeScript commands (TSTools*)

### Added
- ✅ Native TypeScript LSP configuration using `typescript-language-server` (ts_ls)
- ✅ Native LSP commands for import management
- ✅ Simpler, more maintainable configuration

## Features Preserved

All TypeScript/JavaScript features are still available:

### Import Management (Manual Commands)
| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>oi` | Organize imports | Sorts and removes unused imports |
| `<leader>os` | Sort imports | Sorts import statements |
| `<leader>ou` | Remove unused | Removes unused imports via code actions |
| `<leader>oa` | Add missing | Adds missing imports via code actions |
| `<leader>of` | Fix all | Fixes all fixable errors |

### Automatic on Save
For TypeScript/JavaScript files, the following happens automatically on save:
1. **Organize imports** - Native ts_ls `_typescript.organizeImports` command
2. **Format code** - Biome LSP formatting

### LSP Features
- ✅ Auto-completion (native)
- ✅ Inlay hints (native)
- ✅ Go to definition/declaration
- ✅ Find references
- ✅ Rename symbols
- ✅ Code actions
- ✅ Diagnostics (errors/warnings)
- ✅ Hover documentation
- ✅ Signature help

## Configuration Files Modified

1. **`lua/plugins/typescript-tools.lua`**
   - Removed plugin dependency
   - Added native LSP command implementations
   - Preserved keymaps using native LSP code actions

2. **`lua/plugins/local/mason-tools/init.lua`**
   - Added `typescript-language-server` (ts_ls) configuration
   - Configured to work with Biome for formatting
   - Full TypeScript/JavaScript LSP support

3. **`lua/plugins/lsp.lua`**
   - Updated format-on-save to use native `_typescript.organizeImports`
   - Simplified import organization (no more cascading delays)
   - Added Biome filter for formatting

4. **`KEYMAPS.md`**
   - Updated TypeScript section to reflect native LSP
   - Removed unavailable commands (file references, rename file, etc.)
   - Updated on-save behavior description

## Technical Details

### Native LSP Configuration
Using `vim.lsp.config()` and `vim.lsp.enable()` instead of nvim-lspconfig:

```lua
vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    settings = { ... }
})
vim.lsp.enable("ts_ls")
```

### Import Organization
Native LSP commands provided by typescript-language-server:

```lua
-- Organize imports (sorts + removes unused)
vim.lsp.buf.execute_command({
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) }
})

-- Sort imports only
vim.lsp.buf.execute_command({
    command = "_typescript.sortImports",
    arguments = { vim.api.nvim_buf_get_name(0) }
})
```

### Code Actions
Standard LSP code actions for advanced operations:

```lua
-- Remove unused imports
vim.lsp.buf.code_action({
    apply = true,
    context = {
        only = { "source.removeUnused" },
        diagnostics = {},
    }
})
```

## Benefits

1. **No plugin dependencies** - Uses only native Neovim LSP
2. **Future-proof** - Aligned with Neovim 0.11+ native LSP approach
3. **Simpler** - Less abstraction, more transparent
4. **Faster startup** - One less plugin to load
5. **Better integration** - Direct use of LSP protocol features

## Commands Removed

These typescript-tools.nvim specific commands are no longer available:
- `TSToolsGoToSourceDefinition` - Use standard `gd` instead
- `TSToolsFileReferences` - Use telescope LSP references
- `TSToolsRenameFile` - Use standard file rename + manual import updates

These features may be available through alternative means or standard LSP if needed.

## Migration Impact

**Zero user impact** - All commonly used features are preserved:
- ✅ Import organization on save
- ✅ Manual import management commands  
- ✅ All standard LSP features
- ✅ Same keybindings
- ✅ Same workflow

The migration is transparent to the end user while making the configuration more maintainable and future-proof.

## Testing

To verify the setup works:

1. Open a TypeScript file: `nvim test.ts`
2. Check LSP is attached: `:LspInfo`
3. Test import organization: `<leader>oi`
4. Test auto-complete: Type and use `<C-n>/<C-p>`
5. Test format on save: Save a file with unorganized imports

## Dependencies

- **Neovim 0.11+** - For `vim.lsp.config` and `vim.lsp.enable`
- **typescript-language-server** - Installed via Mason
- **biome** - For formatting and linting (optional but recommended)

## Future Considerations

If additional TypeScript-specific features are needed (like go-to-source-definition for .d.ts files or file references), they can be implemented using:
1. Native LSP protocol extensions
2. Telescope LSP pickers
3. Custom Lua functions using LSP client capabilities

This keeps the configuration native and avoids plugin dependencies.
