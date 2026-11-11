#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
. "$REPO_ROOT/cmd/lib.bash"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Ghostty installation is currently supported only on macOS" >&2
    exit 1
fi

brew install --cask ghostty

GHOSTTY_CONFIG_PATH="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_CONFIG_PATH"
link "$REPO_ROOT/configs/ghostty/config" "$GHOSTTY_CONFIG_PATH/config"
link "$REPO_ROOT/configs/ghostty/themes/pustota" "$HOME/.config/ghostty/themes/pustota"

[[ -d "/Applications/Ghostty.app" ]] || {
    echo "Ghostty installation completed but Ghostty.app was not found" >&2
    exit 1
}

echo "Ghostty installed and configured"
