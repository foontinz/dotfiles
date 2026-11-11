#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
. "$REPO_ROOT/cmd/lib.bash"

# install tb CLI
brew tap touchbistro/tap
brew install touchbistro/tap/tb

# add registries
tb registry add TouchBistro/tb-registry-example
tb registry add foontinz/touch-bistro-registry

# copy config
link "$REPO_ROOT/configs/tb/tbrc.yml" "$HOME/.tbrc.yml"
