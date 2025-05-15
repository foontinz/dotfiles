#!/bin/bash

ROOT_PATH="$HOME/dev/dotfiles"
NEOVIM_PATH="$HOME/dev/nightly-builds/neovim"
NEOVIM_CONFIG_PATH="$HOME/.config/nvim"
NEOVIM_CACHE="$HOME/.cache/nvim"
NEOVIM_STATE="$HOME/.local/share/nvim"
NEOVIM_SHARE="$HOME/.local/state/nvim"

# uninstall neovim
sudo rm -rf "$NEOVIM_PATH"
sudo rm -rf "$NEOVIM_CONFIG_PATH"
sudo rm -rf "$NEOVIM_SHARE"
sudo rm -rf "$NEOVIM_STATE"
sudo rm -rf "$NEOVIM_CACHE"

# install neovim
git clone https://github.com/neovim/neovim "$NEOVIM_PATH"
cd "$NEOVIM_PATH"

sudo make CMAKE_BUILD_TYPE=Release
sudo make install

# add config
cp -r "$ROOT_PATH/configs/nvim" $NEOVIM_CONFIG_PATH
