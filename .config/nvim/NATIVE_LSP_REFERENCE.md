# Native LSP API Quick Reference (Neovim 0.11+)

## Basic Setup

### 1. Configure an LSP Server
```lua
vim.lsp.config('servername', {
  cmd = { 'language-server-command' },
  filetypes = { 'filetype1', 'filetype2' },
  root_markers = { 'pattern1', 'pattern2' },
  settings = {
    -- Server-specific settings
  }
})
```

### 2. Enable the Server
```lua
vim.lsp.enable('servername')
```

### 3. Or Enable for Specific Buffers
```lua
vim.lsp.enable('servername', bufnr)
```

## Configuration Options

### Required Fields
- `cmd` - Command to start the LSP server (array)
- `filetypes` - File types to attach to (array)

### Common Fields
- `root_markers` - Files/dirs that indicate project root (array)
  - Can use nested arrays for priority: `{ { 'file1', 'file2' }, '.git' }`
- `settings` - LSP server-specific settings (table)
- `init_options` - Initialization options sent to server (table)
- `capabilities` - Client capabilities (table)
- `on_attach` - Function called when client attaches (function)

### Example with All Options
```lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  on_attach = function(client, bufnr)
    -- Custom setup when LSP attaches
  end,
  capabilities = vim.lsp.protocol.make_client_capabilities()
})
```

## Root Directory Detection

### Simple (Single Priority)
```lua
root_markers = { '.git', 'package.json' }
```
Searches for files in order, returns first match.

### Complex (Multiple Priorities)
```lua
root_markers = {
  { '.luarc.json', '.luarc.jsonc' },  -- Priority 1: Either of these
  'stylua.toml',                       -- Priority 2: This file
  '.git'                               -- Priority 3: Git repo
}
```

## Global Configuration

Configure defaults for all LSP servers:
```lua
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }
})
```

## LspAttach Autocommand

Set up keymaps and options when LSP attaches:
```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    
    -- Set buffer options
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
    
    -- Set keymaps
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    
    -- Enable features
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end
})
```

## Useful LSP Functions

### Client Management
```lua
vim.lsp.get_clients()              -- Get all LSP clients
vim.lsp.get_clients({ name = 'lua_ls' })  -- Get specific client
vim.lsp.stop_client(client_id)     -- Stop a client
```

### Buffer Functions
```lua
vim.lsp.buf.hover()                -- Show hover information
vim.lsp.buf.definition()           -- Go to definition
vim.lsp.buf.references()           -- Show references
vim.lsp.buf.implementation()       -- Go to implementation
vim.lsp.buf.type_definition()      -- Go to type definition
vim.lsp.buf.rename()               -- Rename symbol
vim.lsp.buf.code_action()          -- Show code actions
vim.lsp.buf.format()               -- Format buffer
vim.lsp.buf.signature_help()       -- Show signature help
```

### Diagnostics
```lua
vim.diagnostic.config({            -- Configure diagnostics
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.diagnostic.goto_next()         -- Go to next diagnostic
vim.diagnostic.goto_prev()         -- Go to previous diagnostic
vim.diagnostic.open_float()        -- Show diagnostic in float
vim.diagnostic.setloclist()        -- Add to location list
```

### Inlay Hints (0.10+)
```lua
vim.lsp.inlay_hint.enable(true)                    -- Enable globally
vim.lsp.inlay_hint.enable(true, { bufnr = 0 })    -- Enable for buffer
vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })      -- Check if enabled
```

### Completion (0.11+)
```lua
vim.lsp.completion.enable(true, client_id, bufnr, {
  autotrigger = true,
})
```

## Client Capabilities Check

```lua
-- Check if client supports a method
if client:supports_method('textDocument/formatting') then
  -- Client supports formatting
end

-- Common methods to check:
-- textDocument/formatting
-- textDocument/rangeFormatting
-- textDocument/inlayHint
-- textDocument/documentHighlight
-- textDocument/completion
```

## Migration from nvim-lspconfig

### Before (lspconfig)
```lua
require('lspconfig').lua_ls.setup({
  cmd = { 'lua-language-server' },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find({'.git'}, { upward = true, path = fname })[1])
  end,
  settings = { ... }
})
```

### After (Native)
```lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git' },
  settings = { ... }
})
vim.lsp.enable('lua_ls')
```

## Common Patterns

### Conditional Enabling
```lua
-- Enable only for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim' },
  callback = function()
    vim.lsp.enable('lua_ls')
  end
})
```

### Disable Server for Specific Files
```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if bufname:match('/node_modules/') then
      vim.lsp.stop_client(args.data.client_id)
    end
  end
})
```

### Multiple Servers Same Filetype
```lua
-- Both biome and typescript-tools for .ts files
vim.lsp.config('biome', { filetypes = { 'typescript' }, ... })
vim.lsp.config('tsserver', { filetypes = { 'typescript' }, ... })

vim.lsp.enable('biome')
vim.lsp.enable('tsserver')
```

## Troubleshooting

### Check LSP Status
```vim
:checkhealth vim.lsp
:LspInfo
:LspLog
```

### Debug LSP
```lua
vim.lsp.set_log_level('debug')  -- Enable debug logging
```

### View LSP Logs
```vim
:edit ~/.local/state/nvim/lsp.log
```

## Default Keymaps (0.11+)

Neovim creates these global keymaps automatically:
- `grn` - Rename
- `gra` - Code action (Normal + Visual)
- `grr` - References
- `gri` - Implementation
- `grt` - Type definition
- `gO` - Document symbols
- `<C-S>` - Signature help (Insert mode)

And these buffer-local when LSP attaches:
- `K` - Hover (unless keywordprg is set)
- `<C-]>` - Go to definition (via tagfunc)
- `gq` - Format (via formatexpr)
- `<C-X><C-O>` - Completion (via omnifunc)

## See Also

- `:help vim.lsp.config`
- `:help vim.lsp.enable`
- `:help lsp`
- `:help lsp-defaults`
- `:help LspAttach`
