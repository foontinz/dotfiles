#!/bin/bash

ROOT_PATH="$HOME/dev/dotfiles"
HELIX_PATH="$HOME/dev/nightly-builds/helix"
CONFIG_PATH="$HOME/.config"
HELIX_CONFIG_PATH="$CONFIG_PATH/helix"

# uninstall helix 
sudo rm -rf "$HELIX_PATH"
sudo rm -rf "$HELIX_CONFIG_PATH"

# install helix
git clone https://github.com/helix-editor/helix "$HELIX_PATH"
cd "$HELIX_PATH"
cargo install --path helix-term --locked

# move config
cp -r "$ROOT_PATH/configs/helix" "$CONFIG_PATH" 
ln -Ts "$HELIX_PATH/runtime" "$HELIX_CONFIG_PATH/runtime"
