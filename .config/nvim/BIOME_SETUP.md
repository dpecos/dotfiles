# Biome Setup - Format & Lint with LSP

## What is Biome?

Biome is a fast, modern toolchain for web projects that provides:
- **Formatting** (replaces Prettier)
- **Linting** (replaces ESLint)
- **All-in-one** LSP server for JS/TS/JSON/CSS
- **10-100x faster** than Prettier + ESLint combined

## Configuration Changes

### Plugins Removed
- ✗ `conform.nvim` - Using native LSP formatting
- ✗ `nvim-lint` - Using LSP diagnostics
- ✗ Prettier - Replaced by Biome
- ✗ ESLint/oxlint - Replaced by Biome

### LSP Server Added
- ✅ `biome` - Formatting + linting for JS/TS/JSON/CSS via LSP

### Native Features Used
- ✅ `vim.lsp.buf.format()` - Native LSP formatting
- ✅ Format-on-save using `BufWritePre` autocmd
- ✅ LSP diagnostics for linting

## Installation

### 1. Install Biome

```bash
# Via npm (globally)
npm install -g @biomejs/biome

# Via npm (per project)
npm install --save-dev @biomejs/biome

# Via Mason (in Neovim)
:MasonInstall biome
```

### 2. Create biome.json

Create a `biome.json` file in your project root:

```bash
# Initialize Biome configuration
npx @biomejs/biome init
```

Or create manually:

```json
{
  "$schema": "https://biomejs.dev/schemas/1.9.4/schema.json",
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
    "formatWithErrors": false,
    "indentStyle": "tab",
    "indentWidth": 2,
    "lineEnding": "lf",
    "lineWidth": 100
  },
  "javascript": {
    "formatter": {
      "quoteStyle": "double",
      "semicolons": "always",
      "trailingCommas": "all",
      "arrowParentheses": "always"
    }
  }
}
```

### 3. Optional: Add to package.json

```json
{
  "scripts": {
    "format": "biome format --write .",
    "lint": "biome lint .",
    "check": "biome check --write ."
  }
}
```

## Usage in Neovim

### Automatic Formatting

Format on save is **enabled by default** for files with Biome LSP attached.

### Manual Formatting

- **Format current buffer**: `<leader>f`
- **Format command**: `:Format`

### Disable/Enable Auto-formatting

```vim
" Disable globally
:FormatDisable

" Disable for current buffer only
:FormatDisable!

" Re-enable
:FormatEnable
```

### Check LSP Status

```vim
:LspInfo
```

You should see `biome` attached to JS/TS/JSON/CSS files.

## Configuration

### Customize Biome Settings

Edit `biome.json` in your project root. See [Biome docs](https://biomejs.dev/reference/configuration/) for all options.

### Example: Customize Formatting

```json
{
  "formatter": {
    "enabled": true,
    "indentWidth": 2,
    "lineWidth": 80
  },
  "javascript": {
    "formatter": {
      "quoteStyle": "single",
      "semicolons": "asNeeded",
      "trailingCommas": "es5"
    }
  }
}
```

### Example: Configure Linting Rules

```json
{
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true,
      "suspicious": {
        "noExplicitAny": "error"
      },
      "style": {
        "noUnusedTemplateLiteral": "warn"
      }
    }
  }
}
```

## Features

### What Biome Handles

| File Type | Formatting | Linting |
|-----------|------------|---------|
| JavaScript | ✅ | ✅ |
| TypeScript | ✅ | ✅ |
| JSX/TSX | ✅ | ✅ |
| JSON | ✅ | ✅ |
| JSONC | ✅ | ✅ |
| CSS | ✅ | ⚠️ (limited) |

### What's Still Using Other Tools

| File Type | Formatter | Linter |
|-----------|-----------|--------|
| Lua | stylua | LSP |
| Go | gofumpt, goimports | LSP |
| Rust | rustfmt | clippy |
| Shell | shfmt | shellcheck |
| YAML | yamlfmt | yamllint |
| Markdown | markdownlint | markdownlint |

## Commands

### Neovim Commands

```vim
:Format          - Format current buffer
:FormatDisable   - Disable auto-format globally
:FormatDisable!  - Disable auto-format for current buffer
:FormatEnable    - Re-enable auto-format
:LspInfo         - Check LSP status
```

### Biome CLI (in terminal)

```bash
# Format files
biome format --write .

# Lint files
biome lint .

# Format + lint + organize imports
biome check --write .

# Check a specific file
biome check src/index.ts
```

## Troubleshooting

### Biome not formatting/linting

1. **Check if Biome is installed**:
   ```bash
   which biome
   # or
   npx @biomejs/biome --version
   ```

2. **Check LSP is attached**:
   ```vim
   :LspInfo
   ```
   You should see `biome` in the list.

3. **Check for biome.json**:
   Biome needs a `biome.json` file in your project root.

4. **Check file is supported**:
   Biome only handles JS/TS/JSON/CSS files.

### Format not working on save

1. **Check auto-format is enabled**:
   ```vim
   :lua print(vim.g.disable_autoformat)
   ```
   Should be `nil` or `false`.

2. **Check buffer-specific setting**:
   ```vim
   :lua print(vim.b.disable_autoformat)
   ```

3. **Re-enable if disabled**:
   ```vim
   :FormatEnable
   ```

### Conflicts with Prettier/ESLint

If you have Prettier or ESLint configs, you may want to:

1. **Remove old configs**:
   ```bash
   rm .prettierrc .prettierrc.json .prettierrc.js
   rm .eslintrc .eslintrc.json .eslintrc.js
   ```

2. **Remove from package.json**:
   ```json
   // Remove these dependencies
   "prettier": "...",
   "eslint": "...",
   ```

3. **Keep both** (not recommended):
   Biome and Prettier/ESLint can coexist, but may cause conflicts.

## Migration from Prettier/ESLint

### 1. Install Biome

```bash
npm install --save-dev @biomejs/biome
```

### 2. Initialize config

```bash
npx @biomejs/biome init
```

### 3. Import Prettier config (optional)

Biome can import your Prettier settings:

```bash
npx @biomejs/biome migrate prettier --write
```

### 4. Format all files

```bash
npx @biomejs/biome format --write .
```

### 5. Remove old tools

```bash
npm uninstall prettier eslint
rm .prettierrc .eslintrc
```

## Benefits

### Performance

- **10-100x faster** than Prettier + ESLint
- **Written in Rust** - blazing fast
- **Instant feedback** in Neovim via LSP

### Simplicity

- **One tool** instead of multiple
- **One config** instead of several
- **LSP-based** - no need for separate plugins

### Compatibility

- **Drop-in replacement** for Prettier (mostly)
- **Familiar formatting style**
- **Similar ESLint rules**

## Resources

- [Biome Website](https://biomejs.dev/)
- [Biome Documentation](https://biomejs.dev/reference/configuration/)
- [Biome VS Code Extension](https://biomejs.dev/guides/integrate-in-editor/)
- [Migration Guide](https://biomejs.dev/guides/migrate-from-prettier-eslint/)

---

**Status**: ✅ Biome LSP configured and active!
**Format on save**: Enabled by default
**Keybinding**: `<leader>f` to format manually
