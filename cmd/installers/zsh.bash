#!/bin/bash

ROOT_PATH="$HOME/dev/personal/dotfiles"

# install oh-my-zsh (unattended)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# copy zshrc
cp "$ROOT_PATH/cmd/zsh.bash" "$HOME/.zshrc"
