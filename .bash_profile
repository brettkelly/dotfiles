export VISUAL=vim
export EDITOR="$VISUAL"
export DOTFILES="$HOME/dotfiles"
export DOWNLOADS="$HOME/Downloads"
export SHELL="/bin/bash"
export PS1="\u [\w] \\$ "
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# So Apple will stop bugging me about zsh being the default shell
export BASH_SILENCE_DEPRECATION_WARNING=1

# Jacked from github.com/lukesmithxyz; for future use if I end up categorizing 
# home-grown scripts into subdirs.
# export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# History
HISTCONTROL=ignoredups
HISTCONTROL=ignoreboth
HISTFILESIZE=20000 
HISTSIZE=1000

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
