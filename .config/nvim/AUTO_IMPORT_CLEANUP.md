# Automatic Import Cleanup on Save

## Overview

TypeScript and JavaScript files now automatically clean up, organize, and sort imports on save. This ensures your import statements are always tidy without manual intervention.

## What Happens on Save (for TS/JS files)

When you save a TypeScript or JavaScript file, the following sequence executes automatically:

1. **Remove Unused Imports** - Removes any imports that aren't being used in the file
2. **Add Missing Imports** - Adds imports for symbols that are used but not imported
3. **Sort Imports** - Organizes imports in a consistent order
4. **Format Code** - Formats the entire file using Biome

## How It Works

The automatic import cleanup uses `typescript-tools.nvim` commands in sequence:

```lua
-- Step 1: Remove unused
vim.cmd("TSToolsRemoveUnusedImports")

-- Step 2: Add missing
vim.cmd("TSToolsAddMissingImports")

-- Step 3: Sort imports
vim.cmd("TSToolsSortImports")

-- Step 4: Format with Biome
vim.lsp.buf.format()
```

## Manual Import Management

You can still manually trigger these operations individually:

| Keymap | Description |
|--------|-------------|
| `<leader>oi` | Organize imports |
| `<leader>os` | Sort imports |
| `<leader>ou` | Remove unused imports |
| `<leader>oa` | Add missing imports |
| `<leader>of` | Fix all fixable errors |

## Compatibility with Biome

This setup works seamlessly with Biome:

- **TypeScript-tools** handles import management (sorting, adding, removing)
- **Biome** handles code formatting and linting
- Both tools work together during the save sequence

## Disabling Auto-formatting

If you need to disable auto-formatting (including import cleanup):

```vim
:FormatDisable      " Disable globally
:FormatDisable!     " Disable for current buffer only
:FormatEnable       " Re-enable auto-formatting
```

## Files Affected

This automatic cleanup applies to:

- `*.ts` - TypeScript files
- `*.tsx` - TypeScript React files
- `*.js` - JavaScript files
- `*.jsx` - JavaScript React files

## Configuration Files

The automatic import cleanup is configured in:

- **Main config:** `lua/plugins/nvim-lspconfig.lua` (lines 141-180)
- **TS Tools setup:** `lua/plugins/typescript-tools.lua`
- **Keymaps documented in:** `KEYMAPS.md`

## Import Sorting Behavior

The sorting follows TypeScript's default import organization:

1. Side-effect imports (`import './styles.css'`)
2. Third-party imports (`import React from 'react'`)
3. Relative imports (`import { utils } from '../utils'`)
4. Within each group, imports are sorted alphabetically

### Example

**Before save:**
```typescript
import { useState } from 'react';
import { Button } from '../components/Button';
import axios from 'axios';
import './styles.css';
import { format } from 'date-fns';
import { UnusedComponent } from './unused'; // Will be removed
```

**After save:**
```typescript
import './styles.css';
import axios from 'axios';
import { format } from 'date-fns';
import { useState } from 'react';
import { Button } from '../components/Button';
```

## Troubleshooting

### Imports not being sorted on save

1. Make sure you're editing a TS/JS file (check `:set filetype?`)
2. Check that auto-formatting is enabled (`:FormatEnable`)
3. Check that typescript-tools is attached (`:LspInfo`)
4. Check for errors in the LSP log (`:LspLog`)

### Conflicts with Biome

If Biome also tries to organize imports, you may want to disable Biome's import sorting:

```json
{
  "organizeImports": {
    "enabled": false
  }
}
```

This way, typescript-tools handles imports and Biome handles formatting.

### Save is slow

The import cleanup adds small delays (300ms total) to ensure each step completes. If this feels slow:

1. You can disable auto-formatting: `:FormatDisable!`
2. Format manually when needed: `<leader>f`
3. Or adjust the delays in `lua/plugins/nvim-lspconfig.lua`

## Benefits

✅ **Consistency** - All files have the same import organization
✅ **Clean Code** - No unused imports cluttering your files  
✅ **Auto-completion** - Missing imports are added automatically
✅ **Time Saving** - No manual import management needed
✅ **Better Diffs** - Consistent ordering means cleaner git diffs

## Related Documentation

- [KEYMAPS.md](KEYMAPS.md) - All available keymaps
- [BIOME_SETUP.md](BIOME_SETUP.md) - Biome configuration guide
- [TS_JS_UPDATE_SUMMARY.md](TS_JS_UPDATE_SUMMARY.md) - TypeScript tooling overview
