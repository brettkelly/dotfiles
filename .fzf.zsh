# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/brett/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/brett/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/brett/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/brett/.fzf/shell/key-bindings.zsh"
