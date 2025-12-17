#!/usr/bin/env bash
# Install ghostty-vibes theme selector

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create ~/.local/bin if needed
mkdir -p ~/.local/bin

# Symlink theme-select
ln -sf "$SCRIPT_DIR/theme-select" ~/.local/bin/theme-select
echo "Linked: theme-select -> ~/.local/bin/theme-select"

# Add to PATH if needed
add_to_path() {
    local shell_rc="$1"
    if [ -f "$shell_rc" ]; then
        if ! grep -q '.local/bin' "$shell_rc" 2>/dev/null; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$shell_rc"
            echo "Added ~/.local/bin to PATH in $shell_rc"
        fi
    fi
}

add_to_path ~/.zshrc
add_to_path ~/.bashrc

echo ""
echo "Done! Run 'source ~/.zshrc' or open a new terminal."
echo "Then try: theme-select --help"
