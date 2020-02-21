# I jacked most of this from the internet. Shocking, I know.

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Path crap
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Defaults
export VISUAL=vim
export EDITOR="$VISUAL"

# Aliases 
source .aliases

# History
HISTCONTROL=ignoredups
HISTCONTROL=ignoreboth
HISTFILESIZE=20000 
HISTSIZE=1000

# Custom prompt
export PS1="\u [\w] \\$ "

# Homebrew completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

##
# Useful commands are useful.
##
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }


nf () { 
    gvim ~/Development/Scratch/$1 
}

## Create a grayscale/blurred version of an image;
# I use this in my BLOGGING.

grayblurs () {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    plain="${filename%.*}";
    newfile="${plain}.blurred.${extension}";

    convert ${filename} -blur 0x4 -set colorspace Gray -separate -average ${newfile}
}

# Grab a high-resolution thumbnail for a youtube video by URL
ytthumb () {
    vid=$(echo "$1" | perl -ne 'print "$1\n" if /^.+v=(.*)/')
    outf="youtube-$vid.jpg"
    wget -O $outf http://i3.ytimg.com/vi/$vid/maxresdefault.jpg
}

# Same for vimeo
# This used to work, but now does not

# vimeothumb () {
#     wget $(curl -s http://vimeo.com/api/oembed.json?url="${1}" | python -c "import sys,json; print json.load(sys.stdin)['thumbnail_url']") 
# }
