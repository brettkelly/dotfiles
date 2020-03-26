
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases 
source ~/.aliases

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

## Create a grayscale/blurred version of an image;
# I use this in my BLOGGING.

grayblurs () {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    plain="${filename%.*}";
    newfile="${plain}.blurred.${extension}";
    convert ${filename} -blur 0x5 -set colorspace Gray -separate -average ${newfile}
}

## Thumbnail a PDF to a JPG since that's my job now.
pdfthumb () {
    filename=$(basename -- "$1")
    plain="${filename%.*}";
    newfile="${plain}.thumb.jpg";
    convert -density 288 "${1}"[0] -resize 75% -background White -layers flatten "${newfile}"
}

# Grab a high-resolution thumbnail for a youtube video by URL
ytthumb () {
    vid=$(echo "$1" | perl -ne 'print "$1\n" if /^.+v=(.*)/')
    outf="youtube-$vid.jpg"
    wget -O $outf http://i3.ytimg.com/vi/$vid/maxresdefault.jpg
}

# one-shot git add, commit (with args as the commit message) and push to master.
# who's screwing around? we're not.
gcp () {
    git commit -a -m "$*" && git push origin master
}

# quick and ugly way to generate passwords of varying length
genp () {
    if [ "$1" == "" ] ; then
        # default to 12 characters
        OUTP=$(date | md5 | head -c12)
    else
        OUTP=$(date | md5 | head -c${1})
    fi
    echo "${OUTP}"
    echo "${OUTP}" | pbcopy
}

# Get the registrar of a domain without having to sift through hundreds of 
# lines of `whois` output
getreg() {
    whois "$1" | grep -m 1 Registrar\ URL:\ http | sed -e 's/.*: //g'
}

