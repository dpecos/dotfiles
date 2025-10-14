# Verification Checklist - Import Organization Fix

## Pre-Flight Checks

- [ ] Neovim version 0.11+ installed (`nvim --version`)
- [ ] `typescript-language-server` installed (check with `:Mason`)
- [ ] `biome` installed (check with `:Mason`)
- [ ] Config reloaded (restart Neovim or `:source %`)

## Manual Command Tests

### Test 1: Manual Organize Imports
1. [ ] Open/create a test TypeScript file:
   ```bash
   nvim /tmp/test-imports.ts
   ```

2. [ ] Add messy imports:
   ```typescript
   import { useState } from 'react';
   import { useEffect } from 'react';
   import { useMemo } from 'react';
   import { unused } from 'some-lib';
   
   const App = () => {
     const [count] = useState(0);
     useEffect(() => {}, []);
     useMemo(() => {}, []);
     return <div>{count}</div>;
   };
   ```

3. [ ] Wait for LSP to attach (check bottom-right for "ts_ls" indicator)

4. [ ] Press `<leader>oi` to organize imports

5. [ ] Verify imports are:
   - [ ] Combined into single import from 'react'
   - [ ] Sorted alphabetically
   - [ ] Unused import removed

### Test 2: Sort Imports Only
1. [ ] Add imports in random order
2. [ ] Press `<leader>os`
3. [ ] Verify imports are sorted but not combined

### Test 3: Remove Unused
1. [ ] Add an unused import
2. [ ] Press `<leader>ou`
3. [ ] Verify unused import is removed

### Test 4: Add Missing Imports
1. [ ] Use a React hook without importing it
2. [ ] Press `<leader>oa`
3. [ ] Verify import is added (if LSP suggests it)

### Test 5: Fix All
1. [ ] Have some fixable issues
2. [ ] Press `<leader>of`
3. [ ] Verify issues are fixed

## Auto-Organize on Save Tests

### Test 6: Auto-Organize on Save
1. [ ] Open TS file with messy imports
2. [ ] Make a small edit
3. [ ] Save with `:w`
4. [ ] Verify:
   - [ ] Imports are organized
   - [ ] Code is formatted with Biome
   - [ ] No errors in `:messages`

### Test 7: Auto-Format JS Files
1. [ ] Open a JavaScript file with messy imports
2. [ ] Save with `:w`
3. [ ] Verify same behavior as TS

### Test 8: Auto-Format JSX/TSX Files
1. [ ] Open `.jsx` or `.tsx` file
2. [ ] Save with `:w`
3. [ ] Verify imports organized and formatted

## Error Handling Tests

### Test 9: LSP Not Attached
1. [ ] Open a TS file
2. [ ] Immediately try `<leader>oi` (before LSP attaches)
3. [ ] Verify warning message: "ts_ls client not attached"

### Test 10: Non-TS/JS Files
1. [ ] Open a `.lua` or `.py` file
2. [ ] Save with `:w`
3. [ ] Verify:
   - [ ] No organize imports attempted
   - [ ] Still formats (if formatter available)
   - [ ] No errors

## Integration Tests

### Test 11: Biome + ts_ls Working Together
1. [ ] Open TS file
2. [ ] Add messy imports + messy formatting
3. [ ] Save
4. [ ] Verify:
   - [ ] Imports organized (ts_ls)
   - [ ] Code formatted (Biome)
   - [ ] Both work without conflicts

### Test 12: Format Disable Commands
1. [ ] Run `:FormatDisable!` (buffer-only)
2. [ ] Save file
3. [ ] Verify no formatting occurs
4. [ ] Run `:FormatEnable`
5. [ ] Save file
6. [ ] Verify formatting works again

## Performance Tests

### Test 13: Large Files
1. [ ] Open a large TS file (1000+ lines)
2. [ ] Add messy imports at top
3. [ ] Save
4. [ ] Verify:
   - [ ] Organizes imports quickly
   - [ ] Formats without lag
   - [ ] No timeout errors

### Test 14: Multiple Files
1. [ ] Open 3-4 TS files in splits
2. [ ] Make changes to each
3. [ ] Save all with `:wa`
4. [ ] Verify all are organized and formatted

## Edge Cases

### Test 15: Empty File
1. [ ] Create empty TS file
2. [ ] Save
3. [ ] Verify no errors

### Test 16: No Imports File
1. [ ] Create TS file with code but no imports
2. [ ] Save
3. [ ] Verify no errors, just formats

### Test 17: Comment-Only File
1. [ ] Create TS file with only comments
2. [ ] Save
3. [ ] Verify no errors

## Cleanup

- [ ] Remove test files created
- [ ] Check `:messages` for any warnings
- [ ] Check LSP logs if issues: `:LspLog`

## Results

| Test | Status | Notes |
|------|--------|-------|
| Manual organize | ⬜ | |
| Sort imports | ⬜ | |
| Remove unused | ⬜ | |
| Add missing | ⬜ | |
| Fix all | ⬜ | |
| Auto on save (TS) | ⬜ | |
| Auto on save (JS) | ⬜ | |
| Auto on save (JSX/TSX) | ⬜ | |
| LSP not attached | ⬜ | |
| Non-TS/JS files | ⬜ | |
| Biome + ts_ls | ⬜ | |
| Format disable | ⬜ | |
| Large files | ⬜ | |
| Multiple files | ⬜ | |
| Edge cases | ⬜ | |

## Commands Reference

| Command | Description |
|---------|-------------|
| `:LspInfo` | Show LSP client status |
| `:LspLog` | View LSP logs |
| `:messages` | View recent messages |
| `:Mason` | Open Mason installer |
| `:FormatDisable` | Disable auto-format globally |
| `:FormatDisable!` | Disable auto-format for buffer |
| `:FormatEnable` | Enable auto-format |

---

**All tests passing?** ✅ Configuration is working correctly!
**Some tests failing?** ❌ Check `:LspLog` and `:messages` for errors
