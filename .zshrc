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

export PYTHONPATH="/usr/local/lib/python3.8/site-packages/":$PYTHONPATH
export PYTHONWARNINGS="ignore:Unverified HTTPS request"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
