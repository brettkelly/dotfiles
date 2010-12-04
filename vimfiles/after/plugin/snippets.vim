call NERDSnippetsReset()

if has('win32')
    source ~/vimfiles/snippets/support_functions.vim
    call NERDSnippetsFromDirectory("~/vimfiles/snippets")
    call NERDSnippetsFromDirectoryForFiletype('~/vimfiles/snippets/html', 'xhtml')
    call NERDSnippetsFromDirectoryForFiletype('~/vimfiles/snippets/html', 'thtml')
    call NERDSnippetsFromDirectoryForFiletype('~/vimfiles/snippets/html', 'ctp')
    call NERDSnippetsFromDirectoryForFiletype('~/vimfiles/snippets/html', 'php')
else
    source ~/.vim/snippets/support_functions.vim
    call NERDSnippetsFromDirectory("~/.vim/snippets")
    call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'thtml')
    call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'ctp')
    call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'xhtml')
    call NERDSnippetsFromDirectoryForFiletype('~/.vim/snippets/html', 'php')
endif

