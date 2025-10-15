# Tmux Keymaps Reference

This document lists tmux keybindings including default bindings and custom configurations.

**Default Prefix Key:** `Ctrl-b` (referred to as `prefix` below)

---

## Custom Configuration Keybindings

### Configuration Management
- `prefix e` - Edit tmux config in new window with nvim and auto-reload
- `prefix r` - Reload tmux configuration

### Window Management
- `Shift-Left` - Previous window (no prefix needed)
- `Shift-Right` - Next window (no prefix needed)
- `prefix <` - Swap window with previous (repeatable)
- `prefix >` - Swap window with next (repeatable)
- `prefix b` - Toggle to last window

### Pane Management
- `prefix |` - Split pane horizontally (vertical split) in current directory
- `prefix -` - Split pane vertically (horizontal split) in current directory
- `prefix /` - Maximize/unmaximize current pane (ZOOM toggle)

### Pane Resizing (repeatable without re-pressing prefix)
- `prefix Left` - Resize pane left by 3 columns
- `prefix Right` - Resize pane right by 3 columns
- `prefix Up` - Resize pane up by 1 row
- `prefix Down` - Resize pane down by 1 row

### Copy Mode (Vi-style)
- `prefix [` - Enter copy mode
- `v` - Begin selection (in copy mode)
- `Ctrl-v` - Toggle rectangle selection (in copy mode)
- `y` - Copy selection and exit copy mode (in copy mode)

### Navigation (via vim-tmux-navigator plugin)
- `Ctrl-h` - Navigate to left pane (or vim split)
- `Ctrl-j` - Navigate to pane below (or vim split)
- `Ctrl-k` - Navigate to pane above (or vim split)
- `Ctrl-l` - Navigate to right pane (or vim split)

---

## Default Tmux Keybindings

### Session Management
- `prefix $` - Rename current session
- `prefix s` - Choose session from list
- `prefix d` - Detach from session
- `prefix (` - Switch to previous session
- `prefix )` - Switch to next session

### Window Management
- `prefix c` - Create new window
- `prefix ,` - Rename current window
- `prefix &` - Kill current window
- `prefix w` - Choose window from list
- `prefix n` - Next window
- `prefix p` - Previous window
- `prefix l` - Last window (toggle)
- `prefix 0-9` - Switch to window 0-9
- `prefix '` - Prompt for window index to select
- `prefix .` - Prompt for window index to move current window
- `prefix f` - Find window by name

### Pane Management
- `prefix "` - Split pane horizontally (default)
- `prefix %` - Split pane vertically (default)
- `prefix x` - Kill current pane
- `prefix o` - Go to next pane
- `prefix ;` - Go to last active pane
- `prefix q` - Display pane numbers (press number to select)
- `prefix z` - Toggle pane zoom (maximize/restore)
- `prefix !` - Break pane into new window
- `prefix {` - Swap with previous pane
- `prefix }` - Swap with next pane
- `prefix Ctrl-o` - Rotate panes forward
- `prefix Alt-o` - Rotate panes backward
- `prefix Space` - Cycle through pane layouts

### Pane Navigation (arrow keys)
- `prefix ↑` - Select pane above
- `prefix ↓` - Select pane below
- `prefix ←` - Select pane to left
- `prefix →` - Select pane to right

### Pane Resizing (default - not repeatable)
- `prefix Ctrl-↑` - Resize pane up
- `prefix Ctrl-↓` - Resize pane down
- `prefix Ctrl-←` - Resize pane left
- `prefix Ctrl-→` - Resize pane right
- `prefix Alt-↑` - Resize pane up by 5
- `prefix Alt-↓` - Resize pane down by 5
- `prefix Alt-←` - Resize pane left by 5
- `prefix Alt-→` - Resize pane right by 5

### Copy Mode
- `prefix [` - Enter copy mode
- `prefix ]` - Paste from buffer
- `prefix =` - Choose buffer to paste
- `prefix #` - List all paste buffers

#### Copy Mode Navigation (Vi mode enabled)
- `h/j/k/l` - Move cursor left/down/up/right
- `w/b` - Move word forward/backward
- `0/$` - Move to start/end of line
- `Ctrl-d/Ctrl-u` - Half page down/up
- `Ctrl-f/Ctrl-b` - Full page down/up
- `g/G` - Go to top/bottom
- `/` - Search forward
- `?` - Search backward
- `n/N` - Next/previous search match
- `Space` - Start selection
- `Enter` - Copy selection and exit
- `q/Escape` - Exit copy mode

### Command Mode
- `prefix :` - Enter command mode
- `prefix ?` - List all key bindings

### Miscellaneous
- `prefix t` - Show clock
- `prefix i` - Display pane information
- `prefix ~` - Show previous messages
- `prefix m` - Mark current pane
- `prefix M` - Unmark current pane

---

## Configuration Settings

### Behavior
- **Base index:** 1 (windows and panes start at 1, not 0)
- **Mode keys:** Vi (use vi-style navigation in copy mode)
- **Status keys:** Vi (use vi-style navigation in status line)
- **Escape time:** 10ms (reduced for better vim integration)
- **History limit:** 50,000 lines
- **Display time:** 4000ms (4 seconds for messages)
- **Status interval:** 5 seconds
- **Renumber windows:** On (automatically renumber when windows close)
- **Automatic rename:** On (rename window to reflect current program)

### Active Plugins
- **tpm** - Tmux Plugin Manager
- **catppuccin/tmux** - Catppuccin theme (macchiato flavor)
- **christoomey/vim-tmux-navigator** - Seamless navigation between tmux panes and vim splits
- **tmux-plugins/tmux-battery** - Battery status display

### Visual Style
- **Active pane:** White text on black background with cyan border
- **Inactive pane:** Light gray text on dark gray background with gray border
- **Theme:** Catppuccin Macchiato with slanted window status style

---

## Quick Reference Card

### Most Used Commands
```
prefix c        Create window
prefix |        Split horizontal (custom)
prefix -        Split vertical (custom)
Shift-Left/Right Navigate windows (custom)
prefix z        Zoom/unzoom pane
prefix [        Copy mode
prefix d        Detach session
```

### Essential Shortcuts
```
Ctrl-h/j/k/l    Navigate panes (vim-tmux-navigator)
prefix b        Last window (custom)
prefix r        Reload config (custom)
prefix e        Edit config (custom)
```

---

## Command Line Usage

### Session Commands
```bash
tmux new -s <name>          # Create new session
tmux ls                     # List sessions
tmux attach -t <name>       # Attach to session
tmux kill-session -t <name> # Kill session
```

### Quick Start
```bash
tmux                        # Start new session
tmux new -s mysession       # Start new named session
tmux a                      # Attach to last session
tmux a -t mysession         # Attach to named session
```
