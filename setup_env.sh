#!/bin/bash

mkdir -p "$HOME/.config"
if [ ! -d "$HOME/.config/zsh" ]; then
    echo ".config/zsh does not yet exist; cloning repo"
    git clone --depth=1 --recursive https://github.com/matthoffman/zdotdir.git "$HOME/.config/zsh"
else
    echo ".config/zsh already exists, not cloning repo"
fi

if [ ! -f "$HOME/.zshenv" ]; then
    echo ".zshenv does not exist. Linking to $HOME/.config/zsh/.zshenv"
    ln -s "$HOME/.config/zsh/.zshenv" "$HOME/.zshenv"
else
    echo ".zshenv  already exists, not replacing with $HOME/.config/zsh/.zshenv"
fi

_Z=$(which zsh)
if [ $? -eq 0 ]; then
    echo "zsh is installed at $_Z, setting this as default shell"
    chsh -s "${_Z}"
else
    echo "zsh is not installed, not changing shells"
fi

if [ ! -d "$HOME/.dotfiles" ]; then
    echo ".dotfiles does not yet exist; cloning repo"
    git clone --depth=1 --recursive https://github.com/matthoffman/dotfiles.git "$HOME/.dotfiles"
else
    echo ".dotfiles already exists, not cloning repo"
fi

mkdir -p "$HOME/.config/tmux"

if [ ! -f "$HOME/.config/tmux/tmux.conf" ]; then
    echo ".config/tmux/tmux.conf does not yet exist; linking to ${HOME}/.dotfiles/etc/tmux.conf"
    ln -s "${HOME}/.dotfiles/etc/tmux.conf" "$HOME/.config/tmux/tmux.conf"
else
    echo ".config/tmux/tmux.conf already exists, not linking to ${HOME}/.dotfiles/etc/tmux.conf"
fi

echo "Setup script completed"
