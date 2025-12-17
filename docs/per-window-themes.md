# Per-Window Themes (Experimental)

## Goal

Have different Ghostty themes for different tmux windows, auto-switching when you change windows.

## Approach

1. Store theme per tmux window using window options (`@theme`)
2. Use tmux hook `after-select-window` to trigger sync
3. Sync reads window's theme and updates Ghostty config

## Commands Added

```bash
# Set theme for current tmux window
theme-select vibe=security --set-window

# Manually sync (apply current window's theme)
theme-select --sync

# Install tmux hook for auto-sync
theme-select --install-hooks
```

## How It Works

1. `--set-window` stores theme name in tmux: `tmux set-window-option @theme "ThemeName"`
2. `--install-hooks` adds: `tmux set-hook -g after-select-window "run-shell 'theme-select --sync'"`
3. `--sync` reads `tmux show-window-option -v @theme` and writes to Ghostty config

## Known Issues

### Theme doesn't auto-apply on window switch

The hook fires and updates `~/.config/ghostty/config`, but Ghostty doesn't hot-reload the config file. You still need to manually reload (Cmd+Shift+,).

### Potential Solutions (Not Implemented)

1. **OSC Escape Sequences**: Some terminals support changing colors via ANSI escape codes (OSC 10/11/4). This would change colors instantly without config reload. Ghostty support unknown.

2. **Ghostty IPC**: If Ghostty has an IPC mechanism or CLI to trigger reload, the hook could call it.

3. **AppleScript**: On macOS, might be able to script Cmd+Shift+, keystroke:
   ```bash
   osascript -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
   ```

4. **File Watcher**: Ghostty might support auto-reloading config on file change (like some terminals do).

## Current State

The infrastructure is in place:
- Theme storage per window works
- Hook fires on window switch
- Config file gets updated

Missing piece: triggering Ghostty to reload without manual intervention.

## Testing Commands

```bash
# Verify theme is stored on window
tmux show-window-option @theme

# Check if hook is installed
tmux show-hooks -g | grep after-select-window

# Manually test sync
theme-select --sync && cat ~/.config/ghostty/config | grep theme
```
