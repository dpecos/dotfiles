# Neovim Keymaps Reference

Complete reference of all keymaps in this Neovim configuration.

**Legend:**
- 🔧 **Custom** - Manually configured in this setup
- 🔌 **Plugin** - Provided by plugin (internal to plugin)
- ⚙️ **Plugin Config** - Configured for plugin in this setup

**Leader key:** `<Space>`

---

## Table of Contents

1. [Core Neovim (Custom)](#core-neovim-custom)
2. [LSP - Language Server Protocol](#lsp---language-server-protocol)
3. [Completion](#completion)
4. [Code Editing](#code-editing)
5. [Telescope - Fuzzy Finder](#telescope---fuzzy-finder)
6. [File Explorer (nvim-tree)](#file-explorer-nvim-tree)
7. [Buffer Management (Barbar)](#buffer-management-barbar)
8. [Git (GitSigns)](#git-gitsigns)
9. [Rust Development](#rust-development)
10. [Refactoring](#refactoring)
11. [TODO Comments](#todo-comments)
12. [Folding (UFO)](#folding-ufo)
13. [Treesitter Text Objects](#treesitter-text-objects)
14. [Plugin Provided (Internal)](#plugin-provided-internal)

---

## Core Neovim (Custom)

All keymaps marked with 🔧 are custom configurations.

### General

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `jk` | Insert | Exit insert mode | 🔧 |
| `<C-q>` | Normal | Quit all without saving | 🔧 |
| `gf` | Normal | Open file under cursor (create if needed) | 🔧 |

### Configuration Files

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>ve` | Normal | Edit init.lua | 🔧 |
| `<leader>vk` | Normal | Edit keymaps.lua | 🔧 |
| `<leader>vp` | Normal | Edit plugins.lua | 🔧 |
| `<leader>vs` | Normal | Edit settings.lua | 🔧 |

### Movement

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `j` | Normal | Move down (respects wrapped lines) | 🔧 |
| `k` | Normal | Move up (respects wrapped lines) | 🔧 |
| `<C-d>` | Normal | Scroll down (centered) | 🔧 |
| `<C-u>` | Normal | Scroll up (centered) | 🔧 |
| `n` | Normal | Next search result (centered) | 🔧 |
| `N` | Normal | Previous search result (centered) | 🔧 |

### Editing

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `J` | Normal | Join line below (keep cursor position) | 🔧 |
| `J` | Visual | Move selected line down | 🔧 |
| `K` | Visual | Move selected line up | 🔧 |

### Indentation

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<` | Visual | Indent left (keep selection) | 🔧 |
| `>` | Visual | Indent right (keep selection) | 🔧 |

### Search

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>nh` | Normal | Clear search highlights | 🔧 |

### Clipboard (System)

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>y` | Normal/Visual | Yank to system clipboard | 🔧 |
| `<leader>Y` | Normal/Visual | Yank line to system clipboard | 🔧 |
| `<leader>p` | Normal/Visual | Paste from system clipboard | 🔧 |
| `<leader>P` | Normal/Visual | Paste from system clipboard (before) | 🔧 |
| `<C-v>` | Insert | Paste from system clipboard | 🔧 |
| `p` | Visual | Paste over selection (keep register) | 🔧 |

### Registers

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>d` | Normal/Visual | Delete to black hole register | 🔧 |

### Yank Position

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `y` | Visual | Yank (keep cursor position) | 🔧 |
| `Y` | Visual | Yank line (keep cursor position) | 🔧 |

---

## LSP - Language Server Protocol

All LSP keymaps are configured when LSP attaches to a buffer.

### Navigation

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `gd` | Normal | Go to definition | ⚙️ |
| `gD` | Normal | Go to declaration | ⚙️ |
| `gr` | Normal | Go to references (Telescope) | ⚙️ |
| `gi` | Normal | Go to implementation | ⚙️ |
| `gt` | Normal | Go to type definition | ⚙️ |
| `gO` | Normal | Document symbols (Telescope) | ⚙️ |

### Code Actions

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `grn` | Normal | Rename symbol | ⚙️ |
| `gra` | Normal | Code actions | ⚙️ |

### TypeScript/JavaScript Import Management

**Automatic on Save:** Imports are automatically organized (sorted and unused removed) on save for TS/JS files via native LSP.

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>oi` | Normal | Organize imports (TS/JS) | ⚙️ |
| `<leader>os` | Normal | Sort imports (TS/JS) | ⚙️ |
| `<leader>ou` | Normal | Remove unused imports (TS/JS) | ⚙️ |
| `<leader>oa` | Normal | Add missing imports (TS/JS) | ⚙️ |
| `<leader>of` | Normal | Fix all fixable errors (TS/JS) | ⚙️ |

### Documentation

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `K` | Normal | Show hover documentation | ⚙️ |
| `<leader>k` | Normal | Show signature help | ⚙️ |

### Formatting

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>f` | Normal | Format buffer | ⚙️ |

**Note:** For TypeScript/JavaScript files, formatting on save automatically includes:
1. Organizing imports (sorts and removes unused via native ts_ls LSP)
2. Code formatting (via Biome)

### Diagnostics

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `[e` | Normal | Previous error | ⚙️ |
| `]e` | Normal | Next error | ⚙️ |
| `[w` | Normal | Previous warning | ⚙️ |
| `]w` | Normal | Next warning | ⚙️ |
| `<leader>d` | Normal | Toggle diagnostic display mode (cycles 3 modes) | ⚙️ |

### Toggles

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>h` | Normal | Toggle inlay hints | ⚙️ |

### Snippets

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<C-l>` | Insert/Select | Jump to next snippet field | ⚙️ |
| `<C-b>` | Insert/Select | Jump to previous snippet field | ⚙️ |

---

## Completion

Native LSP completion keymaps (configured in settings.lua).

### Trigger & Navigation

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<C-Space>` | Insert | Trigger LSP completion | ⚙️ |
| `<Tab>` | Insert | Next completion item or Tab | ⚙️ |
| `<S-Tab>` | Insert | Previous completion item or Shift-Tab | ⚙️ |
| `<CR>` | Insert | Accept completion or newline | ⚙️ |
| `<C-e>` | Insert | Close completion menu | ⚙️ |

---

## Code Editing

### Commenting (mini.comment)

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `gcc` | Normal | Toggle comment for current line | ⚙️ |
| `gc{motion}` | Normal | Toggle comment for motion | ⚙️ |
| `gc` | Visual | Toggle comment for selection | ⚙️ |
| `gbc` | Normal | Toggle block comment for current line | ⚙️ |
| `gb{motion}` | Normal | Toggle block comment for motion | ⚙️ |
| `gb` | Visual | Toggle block comment for selection | ⚙️ |

**Examples:**
- `gcc` - Comment current line
- `gc2j` - Comment current line and 2 lines below
- `gcip` - Comment inner paragraph
- `gcG` - Comment from cursor to end of file

### Surround (nvim-surround)

Replaces vim-surround with modern Lua implementation.

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `ys{motion}{char}` | Normal | Add surround | ⚙️ |
| `yss{char}` | Normal | Surround entire line | ⚙️ |
| `yS{motion}{char}` | Normal | Add surround on new lines | ⚙️ |
| `ySS{char}` | Normal | Surround line on new lines | ⚙️ |
| `ds{char}` | Normal | Delete surround | ⚙️ |
| `cs{old}{new}` | Normal | Change surround | ⚙️ |
| `cS{old}{new}` | Normal | Change surround (on new lines) | ⚙️ |
| `S{char}` | Visual | Surround selection | ⚙️ |
| `gS{char}` | Visual | Surround selection (on new lines) | ⚙️ |

**Examples:**
- `ysiw"` - Surround inner word with quotes
- `yss)` - Surround line with parentheses
- `ds"` - Delete surrounding quotes
- `cs"'` - Change double quotes to single quotes
- `cs({` - Change `()` to `{ }` with spaces
- `ySS}` - Surround line with `{}` on new lines
- Visual select + `S"` - Surround selection with quotes

**Aliases:**
- `b` → `)` (parentheses)
- `B` → `}` (braces)
- `r` → `]` (brackets)
- `a` → `>` (angle brackets/HTML tag)
- `q` → Any quote (`"`, `'`, `` ` ``)

---

## Telescope - Fuzzy Finder

All Telescope keymaps are custom configured.

### File Finders

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>ff` | Normal | Find files | ⚙️ |
| `<leader>fa` | Normal | Find all files (including hidden) | ⚙️ |
| `<leader>fw` | Normal | Find word under cursor | ⚙️ |
| `<leader>fb` | Normal | Find buffers | ⚙️ |
| `<leader>fh` | Normal | Find help tags | ⚙️ |
| `<leader>fo` | Normal | Find old files (recent) | ⚙️ |

### Search

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>fg` | Normal | Live grep (search in files) | ⚙️ |
| `<leader>fs` | Normal | Grep string under cursor | ⚙️ |

### Git

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>gc` | Normal | Git commits | ⚙️ |
| `<leader>gs` | Normal | Git status | ⚙️ |

### Neovim

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>fk` | Normal | Find keymaps | ⚙️ |
| `<leader>fc` | Normal | Find commands | ⚙️ |

### TODO Comments

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>ft` | Normal | List all TODOs | ⚙️ |

---

## File Explorer (nvim-tree)

### Global Keymaps

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<C-n>` | Normal | Toggle file explorer | ⚙️ |
| `<leader>ee` | Normal | Toggle file explorer | ⚙️ |
| `<leader>er` | Normal | Refresh file explorer | ⚙️ |
| `<leader>ef` | Normal | Find file in tree | ⚙️ |

### Inside nvim-tree Buffer

These keymaps only work when inside the nvim-tree file explorer window.

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<CR>` | Normal | Open file/folder | 🔌 |
| `o` | Normal | Open file/folder | 🔌 |
| `<2-LeftMouse>` | Normal | Open file/folder | 🔌 |
| `v` | Normal | Open in vertical split | 🔌 |
| `s` | Normal | Open in horizontal split | 🔌 |
| `t` | Normal | Open in new tab | 🔌 |
| `<Tab>` | Normal | Preview file | 🔌 |
| `a` | Normal | Create new file/folder | 🔌 |
| `d` | Normal | Delete file/folder | 🔌 |
| `r` | Normal | Rename file/folder | 🔌 |
| `x` | Normal | Cut file/folder | 🔌 |
| `c` | Normal | Copy file/folder | 🔌 |
| `p` | Normal | Paste file/folder | 🔌 |
| `y` | Normal | Copy name | 🔌 |
| `Y` | Normal | Copy relative path | 🔌 |
| `gy` | Normal | Copy absolute path | 🔌 |
| `R` | Normal | Refresh tree | 🔌 |
| `H` | Normal | Toggle hidden files | 🔌 |
| `I` | Normal | Toggle gitignore | 🔌 |
| `W` | Normal | Collapse all | 🔌 |
| `E` | Normal | Expand all | 🔌 |
| `q` | Normal | Close tree | 🔌 |
| `g?` | Normal | Show help | 🔌 |

---

## Buffer Management (Barbar)

All buffer keymaps are custom configured with Barbar plugin.

### Navigation

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<A-,>` | Normal | Previous buffer | ⚙️ |
| `<A-.>` | Normal | Next buffer | ⚙️ |
| `<A-0>` | Normal | Go to last buffer | ⚙️ |

### Movement

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<A-<>` | Normal | Move buffer left | ⚙️ |
| `<A->>` | Normal | Move buffer right | ⚙️ |

### Direct Access

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<A-1>` | Normal | Go to buffer 1 | ⚙️ |
| `<A-2>` | Normal | Go to buffer 2 | ⚙️ |
| `<A-3>` | Normal | Go to buffer 3 | ⚙️ |
| `<A-4>` | Normal | Go to buffer 4 | ⚙️ |
| `<A-5>` | Normal | Go to buffer 5 | ⚙️ |
| `<A-6>` | Normal | Go to buffer 6 | ⚙️ |
| `<A-7>` | Normal | Go to buffer 7 | ⚙️ |
| `<A-8>` | Normal | Go to buffer 8 | ⚙️ |
| `<A-9>` | Normal | Go to buffer 9 | ⚙️ |

### Actions

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<A-p>` | Normal | Pin/unpin buffer | ⚙️ |
| `<A-c>` | Normal | Close buffer | ⚙️ |
| `<C-p>` | Normal | Pick buffer | ⚙️ |

---

## Git (GitSigns)

All Git keymaps are configured when GitSigns attaches to a buffer.

### Hunks

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `]h` | Normal | Next hunk | ⚙️ |
| `[h` | Normal | Previous hunk | ⚙️ |
| `<leader>hs` | Normal/Visual | Stage hunk | ⚙️ |
| `<leader>hr` | Normal/Visual | Reset hunk | ⚙️ |
| `<leader>hS` | Normal | Stage buffer | ⚙️ |
| `<leader>hu` | Normal | Undo stage hunk | ⚙️ |
| `<leader>hR` | Normal | Reset buffer | ⚙️ |
| `<leader>hp` | Normal | Preview hunk | ⚙️ |

### Blame

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>hb` | Normal | Blame line (full) | ⚙️ |
| `<leader>tb` | Normal | Toggle blame for current line | ⚙️ |

### Diff

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>hd` | Normal | Diff this | ⚙️ |
| `<leader>hD` | Normal | Diff this ~ | ⚙️ |
| `<leader>td` | Normal | Toggle deleted | ⚙️ |

### Text Objects

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `ih` | Operator/Visual | Select hunk | ⚙️ |

---

## Rust Development

### Rustacean (Rust files)

All Rust keymaps are configured when opening .rs files with rustaceanvim.

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>rr` | Normal | Run runnables (cargo run, test, bench) | ⚙️ |
| `<leader>rt` | Normal | Run testables | ⚙️ |
| `<leader>rd` | Normal | Run debuggables | ⚙️ |
| `<leader>re` | Normal | Expand macro under cursor | ⚙️ |
| `<leader>rc` | Normal | Open Cargo.toml | ⚙️ |
| `<leader>rp` | Normal | Go to parent module | ⚙️ |
| `<leader>rj` | Normal | Join lines (smart Rust join) | ⚙️ |
| `<leader>rm` | Normal | View MIR (Mid-level IR) | ⚙️ |
| `<leader>rh` | Normal | View HIR (High-level IR) | ⚙️ |
| `K` | Normal | Hover with actions (Rust-enhanced) | ⚙️ |

### Crates (Cargo.toml files)

All crates.nvim keymaps work only in Cargo.toml files.

#### Management

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>ct` | Normal | Toggle crates UI | ⚙️ |
| `<leader>cr` | Normal | Reload crates info | ⚙️ |

#### Updates

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>cu` | Normal | Update crate under cursor | ⚙️ |
| `<leader>cu` | Visual | Update selected crates | ⚙️ |
| `<leader>ca` | Normal | Update all crates | ⚙️ |

#### Upgrades

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>cU` | Normal | Upgrade crate (major version) | ⚙️ |
| `<leader>cU` | Visual | Upgrade selected crates | ⚙️ |
| `<leader>cA` | Normal | Upgrade all crates | ⚙️ |

#### Documentation

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>cd` | Normal | Open crate documentation | ⚙️ |
| `<leader>ch` | Normal | Open crate homepage | ⚙️ |
| `<leader>cp` | Normal | Open repository | ⚙️ |
| `<leader>cC` | Normal | Open crates.io page | ⚙️ |

#### Popups

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>cv` | Normal | Show available versions | ⚙️ |
| `<leader>cf` | Normal | Show crate features | ⚙️ |
| `<leader>cD` | Normal | Show dependencies | ⚙️ |

#### Expansion

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>cx` | Normal | Expand to inline table | ⚙️ |
| `<leader>cX` | Normal | Extract to table | ⚙️ |

---

## Refactoring

All refactoring keymaps use ThePrimeagen/refactoring.nvim.

### Menu

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>rr` | Visual | List of possible refactors | ⚙️ |

### Extract

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>re` | Visual | Extract function | ⚙️ |
| `<leader>rf` | Visual | Extract function to file | ⚙️ |
| `<leader>rv` | Visual | Extract variable | ⚙️ |
| `<leader>rb` | Normal | Extract block | ⚙️ |
| `<leader>rbf` | Normal | Extract block to file | ⚙️ |

### Inline

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>ri` | Normal/Visual | Inline variable | ⚙️ |

**Note:** Rust refactoring uses different prefix (`<leader>r*` for Rust-specific in .rs files, while generic refactoring uses `<leader>r*` in other languages).

---

## TODO Comments

All TODO comment keymaps use folke/todo-comments.nvim.

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `]t` | Normal | Next TODO comment | ⚙️ |
| `[t` | Normal | Previous TODO comment | ⚙️ |
| `<leader>ft` | Normal | List all TODOs (Telescope) | ⚙️ |

---

## Folding (UFO)

Fold keymaps using kevinhwang91/nvim-ufo.

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `zR` | Normal | Open all folds | ⚙️ |
| `zM` | Normal | Close all folds | ⚙️ |

**Note:** Standard Vim fold commands still work (`za`, `zc`, `zo`, etc.).

---

## Treesitter Text Objects

All text object keymaps use nvim-treesitter-textobjects.

### Selection

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `af` | Visual/Operator | Select outer function | ⚙️ |
| `if` | Visual/Operator | Select inner function | ⚙️ |
| `ac` | Visual/Operator | Select outer class | ⚙️ |
| `ic` | Visual/Operator | Select inner class | ⚙️ |
| `ab` | Visual/Operator | Select outer block | ⚙️ |
| `ib` | Visual/Operator | Select inner block | ⚙️ |
| `ai` | Visual/Operator | Select outer call | ⚙️ |
| `ii` | Visual/Operator | Select inner call | ⚙️ |

### Swap

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>a` | Normal | Swap parameter with next | ⚙️ |
| `<leader>A` | Normal | Swap parameter with previous | ⚙️ |

### Movement

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `]m` | Normal | Next function start | ⚙️ |
| `[m` | Normal | Previous function start | ⚙️ |
| `]M` | Normal | Next function end | ⚙️ |
| `[M` | Normal | Previous function end | ⚙️ |
| `]]` | Normal | Next class start | ⚙️ |
| `[[` | Normal | Previous class start | ⚙️ |
| `][` | Normal | Next class end | ⚙️ |
| `[]` | Normal | Previous class end | ⚙️ |

### Peek Definition

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<leader>df` | Normal | Peek function definition | ⚙️ |
| `<leader>dF` | Normal | Peek class definition | ⚙️ |

---

## Plugin Provided (Internal)

These keymaps are internal to plugins and work automatically without configuration.

### Telescope (Inside Picker)

When Telescope picker is open:

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<C-n>` | Insert | Next item | 🔌 |
| `<C-p>` | Insert | Previous item | 🔌 |
| `<Down>` | Insert | Next item | 🔌 |
| `<Up>` | Insert | Previous item | 🔌 |
| `<CR>` | Insert | Select item | 🔌 |
| `<C-x>` | Insert | Go to file in horizontal split | 🔌 |
| `<C-v>` | Insert | Go to file in vertical split | 🔌 |
| `<C-t>` | Insert | Go to file in new tab | 🔌 |
| `<C-u>` | Insert | Scroll preview up | 🔌 |
| `<C-d>` | Insert | Scroll preview down | 🔌 |
| `<C-q>` | Insert | Send to quickfix list | 🔌 |
| `<Esc>` | Insert | Close picker | 🔌 |

### Completion Menu (Inside Completion)

When completion menu is open:

| Keymap | Mode | Description | Type |
|--------|------|-------------|------|
| `<C-n>` | Insert | Next completion | 🔌 |
| `<C-p>` | Insert | Previous completion | 🔌 |
| `<C-y>` | Insert | Confirm completion | 🔌 |
| `<C-e>` | Insert | Close completion | 🔌 |

---

## Keymap Conflicts & Notes

### Special Cases

1. **`<leader>d`** - Has multiple contexts:
   - **Normal mode (general)**: Delete to black hole register
   - **LSP attached**: Toggle diagnostic display mode
   - Context-sensitive based on LSP attachment

2. **`<leader>rr`** - Different by file type:
   - **Rust files (.rs)**: Run Rust runnables
   - **Other files (Visual mode)**: Refactoring menu

3. **`K`** - Context-dependent:
   - **With LSP**: Show hover documentation
   - **Rust files**: Enhanced hover with actions
   - **Visual mode**: Move line up

4. **`<leader>f`** - Namespaced:
   - `<leader>f` alone: Format buffer (LSP)
   - `<leader>f*`: Telescope commands (find files, grep, etc.)

### Disabled/Commented Out

- `<leader>vr` - Reload config (commented out in keymaps.lua)

---

## How to Search Keymaps

### In Neovim

```vim
" View all keymaps
:Telescope keymaps

" Search for specific plugin keymaps
:Telescope keymaps
" Then type: LSP, Telescope, Rust, etc.

" View mode-specific keymaps
:nmap    " Normal mode
:imap    " Insert mode
:vmap    " Visual mode
:map     " All modes

" Check specific keymap
:verbose nmap <leader>ff
```

### In This File

Use your file viewer's search:
- Search for keymap: `/keyword` or `Ctrl+F keyword`
- Search by mode: `/Normal`, `/Visual`, `/Insert`
- Search by type: `/🔧`, `/🔌`, `/⚙️`

---

## Customization

All custom keymaps (🔧 and ⚙️) can be modified in:

- **Core Neovim**: `lua/keymaps.lua`
- **Completion**: `lua/settings.lua`
- **Commenting**: `lua/plugins/mini-comment.lua`
- **Surround**: `lua/plugins/nvim-surround.lua`
- **LSP**: `lua/plugins/nvim-lspconfig.lua`
- **Telescope**: `lua/plugins/telescope.lua`
- **File Explorer**: `lua/plugins/nvim-tree.lua`
- **Buffers**: `lua/plugins/barbar.lua`
- **Rust**: `lua/plugins/rustaceanvim.lua`, `lua/plugins/crates-nvim.lua`
- **Refactoring**: `lua/plugins/refactoring.lua`
- **TODO**: `lua/plugins/todo-comments.lua`
- **Folding**: `lua/plugins/nvim-ufo.lua`
- **Which-Key**: `lua/plugins/which-key.lua`

Plugin-provided keymaps (🔌) are internal to the plugin and typically cannot be changed without modifying the plugin configuration.

---

## Quick Reference by Category

### Most Used

| Category | Prefix | Example |
|----------|--------|---------|
| Commenting | `gc*` | `gcc` (toggle comment) |
| Surround | `ys*/ds/cs` | `ysiw"` (surround word) |
| Telescope | `<leader>f*` | `<leader>ff` (find files) |
| LSP Navigation | `g*` | `gd` (go to definition) |
| LSP Actions | `gr*` | `grn` (rename) |
| Buffers | `<A-*>` | `<A-.>` (next buffer) |
| Git | `<leader>h*` | `<leader>hs` (stage hunk) |
| Rust | `<leader>r*` | `<leader>rr` (runnables) |
| Crates | `<leader>c*` | `<leader>cu` (update crate) |
| Refactor | `<leader>r*` | `<leader>re` (extract) |
| Config | `<leader>v*` | `<leader>ve` (edit init) |

### Which-Key Helper

Press any leader key and wait ~300ms to see available keybindings:
- `<leader>` - Show all leader mappings
- `g` - Show all goto mappings
- `[` / `]` - Show all prev/next mappings
- `<C-w>` - Show all window mappings
- `z` - Show all fold/spell mappings

---

**Last Updated:** 2024
**Neovim Version:** 0.11.4+
