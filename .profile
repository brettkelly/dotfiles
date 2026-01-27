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

# Build PATH dynamically
export PATH="$HOME/.local/bin:$PATH"

# Add Homebrew to PATH if on macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ -d "/opt/homebrew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/Homebrew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    # Add Homebrew Ruby if available
    if [[ -d "/opt/homebrew/opt/ruby/bin" ]]; then
        export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    elif [[ -d "/usr/local/opt/ruby/bin" ]]; then
        export PATH="/usr/local/opt/ruby/bin:$PATH"
    fi
fi

# Add gem directory to PATH if it exists
if [[ -d "$HOME/.gem/ruby/2.7.0/bin" ]]; then
    export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
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


export PATH="$HOME/.poetry/bin:$PATH"

# Cargo (Rust) environment
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
