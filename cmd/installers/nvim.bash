#!/bin/bash

ROOT_PATH="$HOME/dev/dotfiles"
NEOVIM_PATH="$HOME/dev/nightly-builds/neovim"
NEOVIM_CONFIG_PATH="$HOME/.config/nvim"

# uninstall neovim
sudo rm -rf "$NEOVIM_PATH"
sudo rm -rf "$NEOVIM_CONFIG_PATH"

# install neovim
git clone https://github.com/neovim/neovim "$NEOVIM_PATH"
cd "$NEOVIM_PATH"

sudo make CMAKE_BUILD_TYPE=Release
sudo make install

# add config
cp -r "$ROOT_PATH/configs/nvim" $NEOVIM_CONFIG_PATH
