# Source platform detection utilities
if [[ -f "$HOME/.local/lib/platform.sh" ]]; then
    source "$HOME/.local/lib/platform.sh"
fi

# Set editor to nvim (found dynamically in PATH)
if command -v nvim &> /dev/null; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"
export DOTFILES="$HOME/dotfiles/"
export DOWNLOADS="$HOME/Downloads/"
export DEV="$HOME/Development/"
export SCRATCH="$DEV/Scratch/"
export OBSIDIAN_VAULT="$HOME/obsidian-vault/"

# Dynamic shell path detection
if command -v zsh &> /dev/null; then
    export SHELL="$(command -v zsh)"
else
    export SHELL="/bin/zsh"
fi

#export PS1="\u [\w] \\$ "

# Build PATH dynamically and idempotently
path_prepend_if_dir() {
    [ -d "$1" ] || return
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

path_prepend_if_dir "$HOME/.local/bin"

# Add Homebrew to PATH if on macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ -d "/opt/homebrew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/Homebrew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    # Add Homebrew Ruby if available
    if [[ -d "/opt/homebrew/opt/ruby/bin" ]]; then
        path_prepend_if_dir "/opt/homebrew/opt/ruby/bin"
    elif [[ -d "/usr/local/opt/ruby/bin" ]]; then
        path_prepend_if_dir "/usr/local/opt/ruby/bin"
    fi
fi

# Add gem directory to PATH if it exists
if [[ -d "$HOME/.gem/ruby/2.7.0/bin" ]]; then
    path_prepend_if_dir "$HOME/.gem/ruby/2.7.0/bin"
fi

# Jacked from github.com/lukesmithxyz; for future use if I end up categorizing 
# home-grown scripts into subdirs.
# export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# History
HISTCONTROL=ignoredups
HISTCONTROL=ignoreboth
HISTFILESIZE=20000 
HISTSIZE=1000

#if [ -f ~/.bashrc ]; then
   #source ~/.bashrc
#fi

# Give me vi keybindings in bash
#set -o vi


path_prepend_if_dir "$HOME/.poetry/bin"
export PATH

# Cargo (Rust) environment
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
