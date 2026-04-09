# Neovim Configuration

## 🚀 Quick Start

### First Time Setup

1. **Open Neovim** - Plugins will auto-install on first launch
   ```bash
   nvim
   ```

2. **Sync plugins** (if needed)
   ```vim
   :Pack
   ```

3. **Install LSP servers and tools**
   ```vim
   :Mason
   ```

4. **Check health**
   ```vim
   :checkhealth
   ```

## 🐛 Troubleshooting

### LSP not working
```vim
:LspInfo          " Check attached LSP servers
:Mason            " Install/update LSP servers
:checkhealth lsp  " Check LSP health
```

### Slow startup
```bash
nvim --startuptime startup.log
tail -20 startup.log
```

### General issues
```vim
:checkhealth      " Check overall health
```
