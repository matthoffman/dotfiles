#!/bin/bash

command -v git >/dev/null 2>&1 || { echo >&2 "git is required but it's not installed.  Aborting."; exit 1; }

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

_Z=$(command -v zsh || true)
if [ -n "$_Z" ]; then
    _me=$(id -un)
    # Current login shell, portably: getent on Linux, dscl on macOS, $SHELL as a last resort.
    _current=$(getent passwd "$_me" 2>/dev/null | cut -d: -f7)
    if [ -z "$_current" ]; then
        _current=$(dscl . -read "/Users/$_me" UserShell 2>/dev/null | awk '{print $2}')
    fi
    [ -n "$_current" ] || _current="$SHELL"

    if [ "$_current" = "$_Z" ]; then
        echo "login shell is already $_Z, not changing shells"
    else
        echo "zsh is installed at $_Z, setting this as default shell (current: $_current)"
        # A bare `chsh` prompts for a password, which hangs any non-interactive run
        # of this script -- e.g. the Netflix Workspaces dotfiles installer, which
        # runs at workspace start with no terminal attached. Prefer non-interactive
        # sudo, fall back to plain chsh only when there is a tty, and never let a
        # failure here abort the caller.
        if sudo -n true 2>/dev/null; then
            sudo -n chsh -s "$_Z" "$_me" ||
                echo "could not change shell via sudo; run by hand: sudo chsh -s $_Z $_me"
        elif [ -t 0 ]; then
            chsh -s "$_Z" || echo "chsh failed; run by hand: chsh -s $_Z"
        else
            echo "no passwordless sudo and no terminal; skipping chsh. Run by hand: sudo chsh -s $_Z $_me"
        fi
    fi
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
