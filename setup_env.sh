in/bash

mkdir -p "$HOME/.config"
if [ ! -d "$HOME/.config/zsh" ]; then
        git clone --depth=1 --recursive https://github.com/matthoffman/zdotdir.git "$HOME/.config/zsh"
fi

if [ -f "$HOME/.zshenv" ]; then
        ln -s "$HOME/.config/zsh/.zshenv" "$HOME/.zshenv"
fi

_Z=$(which zsh)
if [ $? -eq 0 ]; then
        chsh -s "${_Z}"
else
        echo "zsh is not installed, not changing shells"
fi

if [ ! -d "$HOME/.dotfiles" ]; then
        git clone --depth=1 --recursive https://github.com/matthoffman/dotfiles.git "$HOME/.dotfiles"
fi

mkdir -p "$HOME/.config/tmux"

if [ ! -f "$HOME/.config/tmux/tmux.conf" ]; then
        ln -s "${HOME}/.dotfiles/etc/tmux.conf" "$HOME/.config/tmux/tmux.conf"
fi
