#!/bin/bash
source "$HOME/.config/dotfiles/load.sh"
source "$HOME/.aliasrc"

export PATH=$HOME/.local/share/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
export ZSH_DISABLE_COMPFIX="true"
export TRASH="$HOME/.local/share/Trash/files"

ZSH_THEME="macovsky"

if [[ "$XDG_SESSION_DESKTOP" = "bspwm" ]]; then
    cat "$HOME/.cache/wal/sequences"
fi

plugins=(
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh
source "$HOME/.config/dotfiles/shellrc.sh"
