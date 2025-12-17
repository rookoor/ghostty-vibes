# ghostty-vibes

Kubernetes-style vibe-based theme selector for Ghostty terminal.

## Usage

```bash
# List themes by vibe
./theme-select vibe=action

# Multiple selectors (AND)
./theme-select vibe=security energy=high

# Random pick
./theme-select vibe=cozy --random

# Apply to ghostty config
./theme-select vibe=security --apply

# List all available labels
./theme-select --list-labels

# Show current theme
./theme-select --current
```

## Labels

Themes are tagged with Kubernetes-style labels:

| Label | Values |
|-------|--------|
| `vibe` | action, balanced, chaos, cozy, focus, nature, ominous, playful, professional, retro, scifi, security |
| `energy` | low, medium, high, extreme |
| `mood` | calm, intense, electric, mysterious, warm, cold, danger, etc. |
| `use-case` | default, hacking, work, test, morning, evening, etc. |
| `brightness` | dark, light |
| `feedback` | dislike, favorite |

## Feedback Labels

Mark themes you don't like to exclude them from future selections:

```yaml
- name: Alien Blood
  labels:
    vibe: ominous, security
    feedback: dislike    # Never selected
```

- `dislike` - theme is excluded from all searches
- `favorite` - reserved for future priority features

## Comma-Separated Values

Labels support comma-separated values for themes that fit multiple categories:

```yaml
- name: Cyberpunk
  labels:
    vibe: action, security    # Matches both vibe=action AND vibe=security
    energy: high
    mood: intense
```

Searching for `vibe=security` will match any theme where "security" appears in the vibe list.

## Adding New Vibes

When a vibe doesn't exist in the current list:

1. **Search for it anyway** - if no results, proceed to step 2
2. **Use an agent to analyze themes** - have an AI review the theme list and identify which themes match the new vibe
3. **Tag matching themes** - add the new vibe as a comma-separated value to matching themes
4. **Future searches work** - the vibe is now searchable

### Example: Adding "security" vibe

```bash
# Search returns nothing
./theme-select vibe=security
# No themes match selectors: vibe=security

# Have an agent identify matches based on:
# - Theme names suggesting security (Cyberdyne, Doom One, etc.)
# - Existing labels (use-case=hacking, mood=danger, vibe=ominous)
# - Overall aesthetic (dark, serious, cyber)

# Agent identifies: Cyberpunk, Challenger Deep, Homebrew, Cyberdyne,
#                   Pro, Doom One, Alien Blood, Dracula

# Update themes.yaml - add "security" to vibe labels
# vibe: action --> vibe: action, security

# Now searches work
./theme-select vibe=security
# Returns 8 matches
```

This approach ensures:
- New vibes are added organically based on actual need
- Themes are tagged consistently by AI analysis
- The vibe vocabulary grows over time
- No manual maintenance of vibe definitions

## Files

| File | Description |
|------|-------------|
| `theme-select` | Bash/Python script for searching and applying themes |
| `themes.yaml` | Theme metadata with Kubernetes-style labels |

## Integration

### With Ghostty

```bash
# Add to your shell profile
export PATH="$PATH:/path/to/ghostty-vibes"

# Or symlink
ln -s /path/to/ghostty-vibes/theme-select ~/.local/bin/theme-select
```

### With tmux

Create different vibes per tmux window/session:

```bash
# In your workflow script
tmux new-window -n "vault"
theme-select vibe=security --apply
# Reload ghostty: Cmd+Shift+,
```

## License

MIT
