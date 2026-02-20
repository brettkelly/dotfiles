# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- History Configuration ----
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ---- Completion ----
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete
_comp_options+=(globdots)

# ---- Key Bindings ----
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
#bindkey -v # vim motions

# ---- Path Configuration ----
typeset -U PATH
path=(
    "$HOME/.local/bin"
    $path
)

# Add platform-specific paths
if [[ "$(uname -s)" == "Darwin" ]]; then
    # macOS Python user packages
    if [[ -d "$HOME/Library/Python/3.9/bin" ]]; then
        path=("$HOME/Library/Python/3.9/bin" $path)
    fi

    # Legacy Homebrew paths (for older installations)
    if [[ -d "/usr/local/sbin" ]]; then
        path=("/usr/local/sbin" $path)
    fi
fi

# ---- Development Tools ----
# Python/Pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Poetry
if [[ -d "$HOME/.poetry/bin" ]]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi
export PATH="$HOME/.local/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Java
if [[ "$(uname -s)" == "Darwin" ]] && [[ -x /usr/libexec/java_home ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
elif command -v java &> /dev/null; then
    # On Linux, try to find JAVA_HOME
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java) 2>/dev/null || which java)))
fi

# PHP - dynamically find PHP from Homebrew or system
if command -v brew &> /dev/null; then
    # Try to find PHP 8.1 from Homebrew
    local brew_prefix=$(brew --prefix 2>/dev/null)
    if [[ -d "$brew_prefix/opt/php@8.1/bin" ]]; then
        export PATH="$brew_prefix/opt/php@8.1/bin:$PATH"
        export PATH="$brew_prefix/opt/php@8.1/sbin:$PATH"
    elif [[ -d "$brew_prefix/opt/php/bin" ]]; then
        export PATH="$brew_prefix/opt/php/bin:$PATH"
        export PATH="$brew_prefix/opt/php/sbin:$PATH"
    fi
fi

# ---- Tool Configuration ----
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Zoxide
eval "$(zoxide init zsh)"

# ---- OS-Specific Configuration ----
if [[ `uname` == "Linux" ]]; then
    source ~/.linux.zsh
fi

# ---- Sources ----
source ~/.aliases

# Load zsh plugins with dynamic path detection
# Source platform utilities if available
if [[ -f "$HOME/.local/lib/platform.sh" ]]; then
    source "$HOME/.local/lib/platform.sh"

    # Powerlevel10k
    local p10k_path=$(find_p10k_theme 2>/dev/null)
    if [[ -n "$p10k_path" && -f "$p10k_path" ]]; then
        source "$p10k_path"
    fi

    # zsh-autosuggestions
    local autosuggestions_path=$(find_zsh_plugin "zsh-autosuggestions" 2>/dev/null)
    if [[ -n "$autosuggestions_path" && -f "$autosuggestions_path" ]]; then
        source "$autosuggestions_path"
    fi

    # zsh-syntax-highlighting
    local highlighting_path=$(find_zsh_plugin "zsh-syntax-highlighting" 2>/dev/null)
    if [[ -n "$highlighting_path" && -f "$highlighting_path" ]]; then
        source "$highlighting_path"
    fi
else
    # Fallback to direct paths if platform utilities not available
    # Try Homebrew locations (macOS)
    if [[ -f "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
    elif [[ -f "/usr/local/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
    elif [[ -f "/usr/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        source /usr/share/powerlevel10k/powerlevel10k.zsh-theme
    fi

    if [[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    elif [[ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi

    if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    elif [[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
fi

# ---- Theme Configuration ----
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---- Perl Configuration ----
if [[ -d "$HOME/perl5" ]]; then
    PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
    PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
    PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
    PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
fi

# opencode
export PATH=/Users/brett/.opencode/bin:$PATH
