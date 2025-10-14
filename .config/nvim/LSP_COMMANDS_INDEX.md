# LSP Commands - Documentation Index

Quick navigation guide to all LSP Commands documentation.

## 🚀 Getting Started

**New to these commands?** Start here:

1. **[Quick Reference](LSP_COMMANDS_QUICK_REF.md)** ⭐
   - One-page summary of all commands
   - Quick examples
   - Common troubleshooting
   - **Start here if you just want to use the commands**

## 📚 Complete Documentation

### User Guides

2. **[Complete Command Reference](LSP_COMMANDS.md)**
   - Detailed description of each command
   - All features and capabilities
   - Usage examples
   - Troubleshooting guide
   - Comparison with nvim-lspconfig
   - **Read this for complete understanding**

3. **[Example Outputs](LSP_COMMANDS_EXAMPLES.md)**
   - What each command actually shows
   - Real-world usage scenarios
   - Tips and tricks
   - Debugging workflows
   - **Read this to see what to expect**

### Technical Documentation

4. **[Implementation Details](LSP_COMMANDS_IMPLEMENTATION.md)**
   - Technical implementation details
   - Native APIs used
   - Benefits and features
   - Migration notes from nvim-lspconfig
   - **Read this if you're a developer or want to understand internals**

5. **[Testing Checklist](LSP_COMMANDS_CHECKLIST.md)**
   - Comprehensive testing guide
   - Edge cases and scenarios
   - Quality assurance
   - Quick test script
   - **Use this to verify everything works**

6. **[Summary](LSP_COMMANDS_SUMMARY.txt)**
   - Text-based overview
   - Key features and benefits
   - Quick reference
   - **Read this for a high-level overview**

## 🗺️ Related Documentation

### Configuration & Keymaps

- **[KEYMAPS.md](KEYMAPS.md)**
  - All keymaps in the configuration
  - LSP Commands section (search for "LSP Commands")
  - Complete keymap reference

### LSP Configuration

- **[lua/plugins/lsp.lua](lua/plugins/lsp.lua)**
  - Source code for LSP configuration
  - Commands are defined starting at line 426
  - Native vim.lsp.config/enable implementation

## 📖 Documentation by Purpose

### I want to...

| Goal | Read This |
|------|-----------|
| **Just use the commands** | [Quick Reference](LSP_COMMANDS_QUICK_REF.md) |
| **Understand what each command does** | [Command Reference](LSP_COMMANDS.md) |
| **See example outputs** | [Examples](LSP_COMMANDS_EXAMPLES.md) |
| **Understand how it works** | [Implementation](LSP_COMMANDS_IMPLEMENTATION.md) |
| **Test the implementation** | [Checklist](LSP_COMMANDS_CHECKLIST.md) |
| **Get a quick overview** | [Summary](LSP_COMMANDS_SUMMARY.txt) |
| **Find all keymaps** | [KEYMAPS.md](KEYMAPS.md) |
| **Modify the code** | [lua/plugins/lsp.lua](lua/plugins/lsp.lua) |

## 🎯 Quick Links by Command

### :LspInfo
- [Quick Ref](LSP_COMMANDS_QUICK_REF.md#lspinfo)
- [Full Guide](LSP_COMMANDS.md#lspinfo)
- [Examples](LSP_COMMANDS_EXAMPLES.md#lspinfo)

### :LspLog
- [Quick Ref](LSP_COMMANDS_QUICK_REF.md#lsplog)
- [Full Guide](LSP_COMMANDS.md#lsplog)
- [Examples](LSP_COMMANDS_EXAMPLES.md#lsplog)

### :LspRestart
- [Quick Ref](LSP_COMMANDS_QUICK_REF.md#lsprestart)
- [Full Guide](LSP_COMMANDS.md#lsprestart)
- [Examples](LSP_COMMANDS_EXAMPLES.md#lsprestart)

### :Format
- [Quick Ref](LSP_COMMANDS_QUICK_REF.md#format)
- [Full Guide](LSP_COMMANDS.md#format)
- [Examples](LSP_COMMANDS_EXAMPLES.md#format)

### :FormatEnable / :FormatDisable
- [Quick Ref](LSP_COMMANDS_QUICK_REF.md#formatenable--formatdisable)
- [Full Guide](LSP_COMMANDS.md#formatenable)
- [Examples](LSP_COMMANDS_EXAMPLES.md#formatenable--formatdisable)

## 🔍 File Sizes

| File | Size | Type |
|------|------|------|
| LSP_COMMANDS_QUICK_REF.md | 2.2K | Quick reference |
| LSP_COMMANDS.md | 6.2K | Complete guide |
| LSP_COMMANDS_EXAMPLES.md | 9.5K | Examples |
| LSP_COMMANDS_IMPLEMENTATION.md | 6.6K | Technical |
| LSP_COMMANDS_CHECKLIST.md | 5.8K | Testing |
| LSP_COMMANDS_SUMMARY.txt | 3.0K | Overview |
| LSP_COMMANDS_INDEX.md | (this file) | Navigation |

## 📝 Recommended Reading Order

### For Users (Just Want to Use)
1. LSP_COMMANDS_QUICK_REF.md
2. LSP_COMMANDS_EXAMPLES.md
3. KEYMAPS.md (for all keybindings)

### For Power Users
1. LSP_COMMANDS.md
2. LSP_COMMANDS_EXAMPLES.md
3. LSP_COMMANDS_IMPLEMENTATION.md

### For Developers/Maintainers
1. LSP_COMMANDS_IMPLEMENTATION.md
2. lua/plugins/lsp.lua (source code)
3. LSP_COMMANDS_CHECKLIST.md
4. LSP_COMMANDS.md

### For Troubleshooting
1. LSP_COMMANDS_EXAMPLES.md (see example error outputs)
2. LSP_COMMANDS.md (troubleshooting section)
3. Run `:LspLog` to check actual errors

## 💡 Tips

- **Use Ctrl+F** in your editor to search within documentation
- **GitHub**: Files render nicely on GitHub with table of contents
- **Terminal**: Use `less` or `bat` to read markdown files
- **Neovim**: Use `:help lsp` for native LSP help

## 🆘 Need Help?

1. Check [LSP_COMMANDS_QUICK_REF.md](LSP_COMMANDS_QUICK_REF.md) first
2. Look for your issue in [LSP_COMMANDS_EXAMPLES.md](LSP_COMMANDS_EXAMPLES.md)
3. Read troubleshooting in [LSP_COMMANDS.md](LSP_COMMANDS.md)
4. Run `:LspLog` to see actual errors
5. Check `:checkhealth lsp` for system issues

## 📌 Related Neovim Help

From within Neovim:

```vim
:help vim.lsp
:help vim.lsp.config
:help vim.lsp.enable
:help vim.lsp.buf
:help vim.diagnostic
```

## 🔄 Updates

This documentation is current as of:
- **Date**: 2024
- **Neovim Version**: 0.11.4+
- **Implementation Version**: 1.0

---

**Navigate quickly:**
- [↑ Back to top](#lsp-commands---documentation-index)
- [→ Quick Start](LSP_COMMANDS_QUICK_REF.md)
- [→ All Keymaps](KEYMAPS.md)
- [→ Source Code](lua/plugins/lsp.lua)
