# starting anew; the scripts are in .local/bin

export PATH="$HOME/.local/bin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"

source ~/.aliases

# need to set up git integration and make this look nicer
# eventually stash this in ~/.zsh/prompt and load it here
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{blue}%1~%f%b %# '

# run this at the end
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
