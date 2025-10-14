# TypeScript/JavaScript Tooling - Modern Setup

This configuration uses modern, actively-maintained tools for TypeScript and JavaScript development.

## 🚀 Overview

**Language Server:** [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim)
- Modern replacement for typescript-language-server (ts_ls)
- Better performance and faster startup
- More features specifically designed for Neovim
- Active development and maintenance

**Formatter/Linter:** [Biome](https://biomejs.dev/)
- Fast Rust-based formatter and linter
- Replaces ESLint + Prettier
- Handles JS, TS, JSON, CSS
- Format-on-save enabled

**Parser:** [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
- Enhanced syntax highlighting
- Better code navigation
- Supports JS, TS, TSX, JSX, JSDoc

## 📦 What's Installed

### Core Tools
- `typescript-tools.nvim` - TypeScript language server integration
- `biome` - Formatter and linter (via Mason)
- Tree-sitter parsers:
  - `javascript` - JavaScript
  - `typescript` - TypeScript
  - `tsx` - TypeScript JSX (React)
  - `jsdoc` - JSDoc comments
  - `json`, `jsonc` - JSON with comments
  - `html`, `css`, `scss` - Web languages

### Removed (Replaced by Modern Tools)
- ❌ `typescript-language-server` (ts_ls) → ✅ typescript-tools.nvim
- ❌ `eslint` → ✅ Biome
- ❌ `prettier` → ✅ Biome
- ❌ `conform.nvim` → ✅ Native LSP formatting

## ⌨️ Keymaps

### TypeScript-Specific (typescript-tools.nvim)

All keymaps are prefixed with "TS Tools:" in the description.

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>oi` | `:TSToolsOrganizeImports` | Organize imports (remove unused, sort) |
| `<leader>os` | `:TSToolsSortImports` | Sort imports only |
| `<leader>ou` | `:TSToolsRemoveUnusedImports` | Remove unused imports |
| `<leader>oa` | `:TSToolsAddMissingImports` | Add missing imports |
| `<leader>of` | `:TSToolsFixAll` | Fix all auto-fixable errors |
| `gds` | `:TSToolsGoToSourceDefinition` | Go to source (not .d.ts) |
| `grf` | `:TSToolsFileReferences` | Show files importing this file |
| `<leader>rf` | `:TSToolsRenameFile` | Rename file & update all imports |

### Standard LSP (All Languages)

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `grr` | List references |
| `gri` | List implementations |
| `grn` | Rename symbol |
| `gra` | Code actions |
| `K` | Hover documentation |
| `[e` / `]e` | Previous/Next error |
| `[w` / `]w` | Previous/Next warning |

### Formatting

| Keymap | Description |
|--------|-------------|
| **Auto** | Format on save (enabled) |
| `:Format` | Manually format buffer |
| `:FormatDisable` | Disable auto-format globally |
| `:FormatDisable!` | Disable auto-format for buffer |
| `:FormatEnable` | Re-enable auto-format |

## 🔧 Configuration

### TypeScript Tools Settings

Located in: `lua/plugins/typescript-tools.lua`

**Key Features:**
- ✅ Inlay hints for types and parameters
- ✅ Auto-import completions
- ✅ Organize imports on command
- ✅ Separate diagnostic server (better performance)
- ✅ Smart import suggestions
- ❌ Formatting disabled (Biome handles it)

**Inlay Hints:**
```typescript
// Shows parameter names
doSomething(value: 42)  // Shows: value:

// Shows return types
function test() {  // Shows: → string
  return "hello"
}

// Shows variable types
const data = fetch()  // Shows: Promise<Response>
```

Toggle inlay hints: `<leader>ih` (LSP keymap)

### Biome Configuration

Located in: `biome.json` (in your project root)

Example `biome.json`:
```json
{
  "$schema": "https://biomejs.dev/schemas/1.8.3/schema.json",
  "organizeImports": {
    "enabled": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true
    }
  },
  "formatter": {
    "enabled": true,
    "indentStyle": "tab",
    "lineWidth": 100
  },
  "javascript": {
    "formatter": {
      "quoteStyle": "double",
      "semicolons": "asNeeded"
    }
  }
}
```

Generate config:
```bash
npx @biomejs/biome init
```

### Tree-sitter

Located in: `lua/plugins/treesitter.lua`

**Enhanced Features:**
- Incremental selection (`gnn`, `grn`, `grc`, `grm`)
- Better indentation
- Syntax highlighting
- Code navigation (see Textobjects below)

## 📚 Advanced Features

### Import Management

**Organize Imports (`<leader>oi`):**
1. Removes unused imports
2. Sorts imports by:
   - Built-in modules
   - External packages
   - Internal modules
   - Relative imports
3. Groups imports logically

**Sort Imports (`<leader>os`):**
- Sorts without removing unused imports
- Preserves side-effect imports

**Add Missing Imports (`<leader>oa`):**
- Automatically imports used but unimported symbols
- Smart suggestions based on available exports

**Example:**
```typescript
// Before
import { useState } from 'react'
import { format } from './utils'
import axios from 'axios'
// unused: format

// After <leader>oi
import axios from 'axios'
import { useState } from 'react'
```

### File References

**Use Case:** Find all files importing the current file

**Command:** `grf` or `:TSToolsFileReferences`

**Example:**
```typescript
// In utils.ts
export const helper = () => {}

// Press 'grf' to see:
// - src/components/Button.tsx
// - src/hooks/useData.ts
// - src/pages/Home.tsx
```

### Rename File

**Command:** `<leader>rf` or `:TSToolsRenameFile`

**What it does:**
1. Renames the file
2. Updates all import statements in other files
3. Updates re-export statements

**Example:**
```typescript
// Before: utils.ts
// Rename to: helpers.ts

// All files automatically update:
- import { x } from './utils'
+ import { x } from './helpers'
```

### Source Definition

**Command:** `gds` or `:TSToolsGoToSourceDefinition`

**Use Case:** Jump to implementation instead of type definition

**Example:**
```typescript
// In your code
import { Button } from 'my-ui-lib'
//       ^ Press gds here

// Regular gd goes to: node_modules/my-ui-lib/dist/index.d.ts
// gds goes to: node_modules/my-ui-lib/src/Button.tsx (if available)
```

## 🎯 Project Setup

### New Project

1. **Initialize Biome:**
   ```bash
   npx @biomejs/biome init
   ```

2. **Install TypeScript (if needed):**
   ```bash
   npm install -D typescript @types/node
   npx tsc --init
   ```

3. **Open Neovim:**
   ```bash
   nvim .
   ```
   
   LSP will auto-install on first TS/JS file open.

### Existing Project

1. **Install Biome:**
   ```bash
   npm install -D @biomejs/biome
   npx @biomejs/biome init
   ```

2. **Remove old tools:**
   ```bash
   npm uninstall eslint prettier
   rm .eslintrc* .prettierrc*
   ```

3. **Update scripts:**
   ```json
   {
     "scripts": {
       "format": "biome format --write .",
       "lint": "biome lint .",
       "check": "biome check --apply ."
     }
   }
   ```

## 🔍 Diagnostics

### Inline Diagnostics (Default)

```typescript
const x: number = "string"  ● Type 'string' is not assignable to type 'number'
```

### Toggle Display

Press `<leader>d` to cycle through:
1. **Inline** (virtual_text) - Default
2. **Below code** (virtual_lines) - More detail
3. **Minimal** (signs only) - Clean view

### Diagnostic Sources

1. **TypeScript (typescript-tools):**
   - Type errors
   - Syntax errors
   - Unused variables

2. **Biome:**
   - Linting errors
   - Style issues
   - Best practice violations

## 🚀 Performance

### Optimizations

**typescript-tools.nvim:**
- Separate diagnostic server
- Lazy loading (ft = TS/JS files)
- Disabled member code lens
- Smart publish diagnostics

**Biome:**
- Rust-based (very fast)
- Parallel processing
- Incremental analysis

**Tree-sitter:**
- Incremental parsing
- Lazy loading parsers

### Benchmark

Typical startup time for TS file:
- LSP attach: ~100-300ms
- First diagnostics: ~200-500ms
- Full feature availability: <1s

(Much faster than old ts_ls + eslint + prettier setup)

## 🐛 Troubleshooting

### LSP Not Attaching

1. Check TypeScript is in PATH:
   ```bash
   which typescript-language-server  # Should be in Mason
   ```

2. Check logs:
   ```vim
   :LspInfo
   :LspLog
   ```

3. Restart LSP:
   ```vim
   :LspRestart
   ```

### Biome Not Formatting

1. Check Biome is installed:
   ```bash
   npx @biomejs/biome --version
   ```

2. Check for `biome.json` in project:
   ```bash
   ls biome.json
   ```

3. Check LSP status:
   ```vim
   :LspInfo
   ```
   Should show `biome` attached.

### Organize Imports Not Working

**Option 1:** Use typescript-tools commands:
```vim
:TSToolsOrganizeImports
```

**Option 2:** Use LSP code action:
```vim
<leader>ca  " Code actions
" Select "Organize imports"
```

**Option 3:** Save file (auto-organizes):
```vim
:w
```

### Inlay Hints Not Showing

1. Check Neovim version:
   ```vim
   :version  " Should be 0.10+
   ```

2. Check if enabled:
   ```vim
   :lua =vim.lsp.inlay_hint.is_enabled()
   ```

3. Toggle inlay hints:
   ```vim
   <leader>ih
   ```

## 📊 Comparison

### vs typescript-language-server (ts_ls)

| Feature | ts_ls | typescript-tools |
|---------|-------|------------------|
| Performance | Good | Better |
| Startup Time | ~500ms | ~200ms |
| Organize Imports | Basic | Enhanced |
| File Rename | Manual | Auto-update imports |
| Source Definition | No | Yes |
| File References | No | Yes |
| Neovim Integration | Generic | Native |
| Maintenance | Active | Very Active |

### vs VSCode

| Feature | VSCode | Neovim (This Setup) |
|---------|--------|---------------------|
| Language Server | Built-in | typescript-tools |
| Formatter | Prettier | Biome (faster) |
| Linter | ESLint | Biome (faster) |
| Auto-import | Yes | Yes |
| Organize Imports | Yes | Yes (better) |
| File Rename | Yes | Yes |
| Inlay Hints | Yes | Yes |
| Performance | Medium | Better |

## 🎓 Tips

### Quick Fixes

1. **Add missing import:**
   - Cursor on undefined symbol
   - Press `gra` (code actions)
   - Select "Add import"

2. **Fix all errors:**
   - Press `<leader>of`

3. **Remove unused:**
   - Press `<leader>ou`

### Workflow

**Starting work:**
```vim
" Open file
nvim src/index.ts

" Check issues
]e  " Jump to next error
gra " Fix with code action
```

**Before commit:**
```vim
" Fix all auto-fixable issues
<leader>of

" Organize imports
<leader>oi

" Save (auto-formats)
:w
```

### Custom Keymaps

Add to your config:
```lua
-- Quick fix current line
vim.keymap.set("n", "<leader>qf", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "quickfix" },
      diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 }),
    },
  })
end, { desc = "Quick fix current line" })
```

## 📝 Files

Configuration files:
- `lua/plugins/typescript-tools.lua` - TypeScript LSP config
- `lua/plugins/nvim-lspconfig.lua` - General LSP setup
- `lua/plugins/treesitter.lua` - Parser config
- `lua/plugins/local/mason-tools/init.lua` - Tool definitions

Project files (optional):
- `biome.json` - Biome formatter/linter config
- `tsconfig.json` - TypeScript compiler config

## 🔗 Resources

- [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim)
- [Biome](https://biomejs.dev/)
- [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)

## 📈 Updates

Check for updates:
```vim
:Lazy sync  " Update all plugins
:TSUpdate   " Update Tree-sitter parsers
:Mason      " Update LSP servers
```

## ✅ Summary

**Modern Stack:**
- ✅ typescript-tools.nvim (better than ts_ls)
- ✅ Biome (replaces ESLint + Prettier)
- ✅ Native LSP features (format, completion)
- ✅ Tree-sitter (modern parsing)

**Key Benefits:**
- ⚡ Faster performance
- 🎯 Better TypeScript support
- 🔧 More powerful tools
- 🧹 Simpler configuration
- 📦 Fewer dependencies

**Next Steps:**
1. Open a TS/JS file to trigger LSP install
2. Create `biome.json` in your projects
3. Try the new keymaps (`<leader>oi`, `gds`, etc.)
4. Enjoy better TypeScript development!
