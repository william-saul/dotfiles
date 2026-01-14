# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$HOME/.local/bin:$PATH"

# Set nvim as default editor

export EDITOR="nvim"
export VISUAL="nvim"

# Pacman aliases

p() {
    pacman "$@"
}

sp() {
    sudo pacman "$@"
}

# "You shall not pass" Kitty wrapper
sudo() {
    local REAL_SUDO="/usr/bin/sudo"
    local GIF="$HOME/.config/memes/gandalf.gif"
    local show_gif=false

    "$REAL_SUDO" "$@"
    local status=$?

    if [ $status -ne 0 ]; then
        if command -v kitty >/dev/null 2>&1 \
           && [ -n "$KITTY_WINDOW_ID" ] \
           && kitty +kitten icat --help >/dev/null 2>&1; then
            show_gif=true
        fi

        if $show_gif; then
            kitty +kitten icat --align center "$GIF" 2>/dev/null || true
        else
            echo "Gandalf disapproves! ($GIF)"
        fi
    fi

    return $status
}

# Yazi "y" auto-cd/alias

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

export PATH=$PATH:/opt/resolve/bin

eval "$(starship init bash)"
