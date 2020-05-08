# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/bkelly/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/bkelly/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/bkelly/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/bkelly/.fzf/shell/key-bindings.zsh"
