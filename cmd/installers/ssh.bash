#!/bin/bash
set -euo pipefail

# SSH host config is machine-local and intentionally not tracked in this
# public repo. Keep hosts in ~/.ssh/config directly.
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# generate key if not present (prompts for a passphrase)
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519"
fi
