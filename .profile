export VISUAL=vim
export EDITOR="$VISUAL"
export DOTFILES="$HOME/dotfiles/"
export DOWNLOADS="$HOME/Downloads/"
export DEV="$HOME/Development/"
export SCRATCH="$DEV/Scratch/"
export SHELL="/bin/zsh"
#export PS1="\u [\w] \\$ "
export PATH="/usr/local/opt/ruby/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH"

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
. "$HOME/.cargo/env"
