# starting anew; the scripts are in .local/bin
source ~/.aliases

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# include hidden files in autocomplete
_comp_options+=(globdots)

# Custom prompt
source ~/.zsh/prompt

# run this at the end
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export PYTHONPATH="/usr/local/lib/python3.9/site-packages/":$PYTHONPATH
export PYTHONWARNINGS="ignore:Unverified HTTPS request"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

 export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
