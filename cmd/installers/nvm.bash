#!/bin/bash

# source profile to pick up existing env (e.g. homebrew, path)
[ -f "$HOME/.zprofile" ] && . "$HOME/.zprofile"
[ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"

export NVM_DIR="$HOME/.nvm"

mkdir -p "$NVM_DIR"

# install nvm
PROFILE=/dev/null bash <(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh)

# load nvm and install latest node
. "$NVM_DIR/nvm.sh"
nvm install node
