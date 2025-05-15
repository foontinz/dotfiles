#!/bin/bash

NVM_DIR="$HOME/dev/nightly-builds/nvm"
NVM_ADDON="$ZSH_ADDONS/nvm.sh"

sudo rm -rf "$NVM_DIR" "$NVM_ADDON"
mkdir -p "$NVM_DIR"
mkdir -p "$ZSH_ADDONS"
touch "$NVM_ADDON"

PROFILE="$NVM_ADDON" bash <(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh)
source "$NVM_ADDON"
nvm install node

