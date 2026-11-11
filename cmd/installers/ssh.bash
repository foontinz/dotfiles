#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
. "$REPO_ROOT/cmd/lib.bash"

# create ssh directory if needed
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# copy config
link "$REPO_ROOT/configs/ssh/config" "$HOME/.ssh/config"

# generate key if not present
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    # Prompts for a passphrase; UseKeychain in ssh config keeps it painless.
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519"
fi
