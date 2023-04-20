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
    [[ $VSCODE_SHELL_INTEGRATION ]] || cat "$HOME/.cache/wal/sequences"
fi

plugins=(
    git
    history-substring-search
    colored-man-pages
    command-time
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

# If command execution time above min. time, plugins will not output time.
ZSH_COMMAND_TIME_MIN_SECONDS=5

# Message to display (set to "" for disable).
ZSH_COMMAND_TIME_MSG="Execution time: %s"

# Exclude some commands
ZSH_COMMAND_TIME_EXCLUDE=(nvim ranger)

source $ZSH/oh-my-zsh.sh
source "$HOME/.config/dotfiles/shellrc.sh"

zsh_command_time() {
    if [ -n "$ZSH_COMMAND_TIME" ]; then
        hours=$(($ZSH_COMMAND_TIME/3600))
        min=$(($ZSH_COMMAND_TIME/60))
        sec=$(($ZSH_COMMAND_TIME%60))
        if [ "$ZSH_COMMAND_TIME" -le 60 ]; then
            timer_show="$fg[green]$ZSH_COMMAND_TIME s."
        elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
            timer_show="$fg[yellow]$min min. $sec s."
        else
            if [ "$hours" -gt 0 ]; then
                min=$(($min%60))
                timer_show="$fg[red]$hours h. $min min. $sec s."
            else
                timer_show="$fg[red]$min min. $sec s."
            fi
        fi
        printf "${ZSH_COMMAND_TIME_MSG}\n" "$timer_show"
    fi
}

# DAYS=$((($(date +%s -d 20230417)-$(date +%s))/86400))
# echo "$DAYS Jours restants avant les concours"

# Atuin
eval "$(atuin init zsh)"

# opam configuration
[[ ! -r /home/augustin64/.opam/opam-init/init.zsh ]] || source /home/augustin64/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
