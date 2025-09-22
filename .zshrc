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
    "$HOME/Library/Python/3.9/bin"
    "/usr/local/sbin"
    "/usr/local/opt/mysql@5.7/bin"
    "/usr/local/opt/php@7.4/bin"
    "/usr/local/opt/php@7.4/sbin"
    $path
)

# ---- Development Tools ----
# Python/Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Java
export JAVA_HOME=/usr/libexec/java_home

# PHP
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# ---- Tool Configuration ----
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Zoxide
eval "$(zoxide init zsh)"

# ---- OS-Specific Configuration ----
if [[ `uname` == "Linux" ]]; then
    source ~/.linux.zsh
elif [[ `uname` == "Darwin" ]]; then
    source ~/.mac.zsh
fi

# ---- Sources ----
source ~/.aliases
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Theme Configuration ----
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/Users/brett/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/brett/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/brett/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/brett/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/brett/perl5"; export PERL_MM_OPT;
