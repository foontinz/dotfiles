#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
. "$REPO_ROOT/cmd/lib.bash"

# install tmux
brew install tmux

# install TPM (Tmux Plugin Manager)
[[ -d ~/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# copy config
link "$REPO_ROOT/configs/tmux/tmux.conf" "$HOME/.tmux.conf"
