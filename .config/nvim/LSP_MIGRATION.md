# LSP Migration to Native Neovim 0.11+ API

## Overview
This migration removes the dependency on `nvim-lspconfig` and uses the native `vim.lsp.config()` and `vim.lsp.enable()` APIs introduced in Neovim 0.11.

## What Changed

### Files Modified
1. **lua/plugins/nvim-lspconfig.lua** → **lua/plugins/lsp.lua**
   - Removed `nvim-lspconfig` plugin dependency
   - Now using native `vim.lsp.config()` and `vim.lsp.enable()`
   - Plugin now only contains fidget.nvim and gitsigns.nvim

2. **lua/plugins/typescript-tools.lua**
   - Removed `nvim-lspconfig` dependency

3. **lua/plugins/local/mason-tools/init.lua**
   - Changed `root_dir` functions to `root_markers` arrays
   - Removed `single_file_support` (handled automatically)
   - Added explicit `cmd`, `filetypes` for each server

### API Changes

#### Before (nvim-lspconfig)
```lua
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
  cmd = { "lua-language-server" },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true, path = fname })[1])
  end,
  settings = { ... }
})
```

#### After (Native API)
```lua
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  root_markers = { ".luarc.json", ".git" },
  filetypes = { "lua" },
  settings = { ... }
})
vim.lsp.enable("lua_ls")
```

### Key Differences

1. **root_markers vs root_dir**
   - Old: `root_dir = function(fname) ... end`
   - New: `root_markers = { ".git", "package.json" }`
   - Native API handles the root directory lookup automatically

2. **single_file_support**
   - Old: Explicitly set `single_file_support = true/false`
   - New: Automatically supported, no need to specify

3. **Explicit filetypes**
   - Old: Often inferred by lspconfig
   - New: Must be explicitly specified

4. **Configuration merging**
   - Native API supports configuration merging from multiple sources
   - Priority: `'*'` config → runtimepath configs → explicit configs

## Benefits

### Performance
- No plugin overhead
- Native implementation is faster
- Less code to load on startup

### Maintenance
- One less plugin to maintain
- Following Neovim's official direction
- Future-proof (lspconfig will be deprecated in v3.0.0)

### Features
- All native Neovim 0.11+ features work out of the box
- Better integration with Neovim's LSP infrastructure
- Cleaner configuration API

## LSP Servers Configured

All servers now use the native API:

1. **biome** - JS/TS/JSON/CSS formatter & linter
2. **gopls** - Go language server
3. **lua_ls** - Lua language server
4. **jsonls** - JSON language server
5. **yamlls** - YAML language server
6. **bashls** - Bash language server
7. **prosemd_lsp** - Markdown language server
8. **terraformls** - Terraform language server

**Note:** TypeScript is handled by typescript-tools.nvim, and Rust by rustaceanvim.

## Native Features Used

All native Neovim features (no plugins needed):

- ✓ `vim.lsp.config()` - Configure LSP clients (0.11+)
- ✓ `vim.lsp.enable()` - Enable LSP clients (0.11+)
- ✓ `vim.lsp.completion` - Native completion (0.11+)
- ✓ `vim.snippet` - Native snippets (0.10+)
- ✓ `vim.diagnostic.config()` - Diagnostics (0.10+)
- ✓ `vim.lsp.inlay_hint` - Inlay hints (0.10+)
- ✓ `vim.lsp.buf.format()` - Formatting (0.8+)
- ✓ Document highlighting - Built-in

## Testing

To verify the migration:

1. Open a file with LSP support (e.g., `.lua`, `.ts`, `.go`)
2. Check LSP is attached: `:checkhealth vim.lsp`
3. Test completion: Type and trigger with `<C-n>` or `<C-x><C-o>`
4. Test formatting: `<leader>f` or `:Format`
5. Test diagnostics: Should see inline diagnostics
6. Test go-to-definition: `gd` on a symbol

## Troubleshooting

If LSP doesn't attach:

1. Check server is installed: `:Mason`
2. Check logs: `:LspLog`
3. Verify root markers exist in your project
4. Run: `:checkhealth vim.lsp`

## References

- [Neovim LSP Documentation](https://neovim.io/doc/user/lsp.html)
- [vim.lsp.config() help](`:help vim.lsp.config`)
- [nvim-lspconfig deprecation notice](https://github.com/neovim/nvim-lspconfig#deprecation-notice)
