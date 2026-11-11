#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
. "$REPO_ROOT/cmd/lib.bash"
link "$REPO_ROOT/configs/git/gitconfig" "$HOME/.gitconfig"
link "$REPO_ROOT/configs/ideavim/ideavimrc" "$HOME/.ideavimrc"
