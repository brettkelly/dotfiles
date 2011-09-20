" Brett Kelly
" .vimrc
" http://brettkelly.org

" Save as UTF-8
setglobal fenc=utf8

set enc=utf8

" Jamessan's sweet trick for sourcing vimrc
" without losing syntax highlighting
if !exists("g:loaded_vimrc")
    let g:loaded_vimrc = 1
    set nocompatible     
    set all&
endif

""" Startup
filetype plugin indent on
filetype on
set nobackup writebackup
set nu
syntax on

""" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""" Visual Suspects
set ts=4 
set sw=4
set tw=0 
set nohlsearch 
set statusline=%t%m%r%w%y[C:%c,L:%l][%P]
set cmdheight=2 
set lazyredraw 
set ignorecase
set autoindent
set expandtab
set incsearch
set showmatch
set matchtime=5
set wildmenu
set ruler
set backspace=2
set modeline
set showcmd
set pumheight=5
set noerrorbells
set wrap
set smarttab
set completeopt=menu
set laststatus=2
set hidden

set lcs=tab:>-,trail:-

if v:version >= 700
    set numberwidth=3
endif

""" Platform Dependent Stuff
if has('win32')
    let g:vimdir = expand("~/vimfiles/")
    let g:vimrc  = expand("~/_vimrc")
    set ffs=dos,unix,mac
    set backupdir=$HOME/vim-backup
    set directory=$HOME/vim-tmp
    set linespace=1
    nmap ,h :e! C:\Windows\System32\drivers\etc\hosts <CR>
    nmap ,t :e! C:\Documents\ and\ Settings\Brett\My\ Documents\My\ Dropbox\Projects.txt<CR>
    nmap <F8> :!ctags -R *<CR>
    nmap <F2> :vsplit<CR>
    imap <F3> <ESC>"+gPi
    vmap <F4> <ESC>"+y
    nmap <F3> "+gPi
    nmap <A-$> :BufGrep <C-r><C-w><CR>:copen<CR>
else
    let g:vimdir = expand("~/.vim/")
    let g:vimrc  = expand("~/.vimrc")
    set ffs=unix,mac,dos
    set backupdir=$HOME/.vim/backup
    set directory=$HOME/.vim/tmp
    nmap ,t :e! /Users/inkedmn/Dropbox/Projects.txt<CR>
endif

if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono:h13
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    nmap <F11> :color billw<CR>
    nmap <F12> :color jellybeans<CR>
    colorscheme jellybeans
else
    colorscheme blue
endif


""" Folding 
set foldenable
set foldmethod=indent
set foldlevel=2
set foldcolumn=1


""" Keybindings
" Some mappings to move easily between windows
nmap	<C-h>	<C-w>h
nmap	<C-j>	<C-w>j
nmap	<C-k>	<C-w>k
nmap	<C-l>	<C-w>l

cmap    w!!     %!sudo tee > /dev/null %

" I like emacs C-a and C-e
imap    <C-a> <Home>
imap    <C-e> <End>
nmap    <C-a> <Home>
nmap    <C-e> <End>
cmap    <C-a> <Home>
cmap    <C-e> <End>
vmap    <C-a> <Home>
vmap    <C-e> <End>

" Show me da bufferz
nmap    <F5>    \be
imap    <F5>    \be

" Edit and source .vimrc easily
nmap    ,v :e! `=g:vimrc`<CR>
nmap    ,s :source `=g:vimrc`<CR>

" ctags
let Tlist_WinWidth = 40
map <F4> :TlistToggle<cr>


" Abbreviations and Mappings
iabbr   enctp   enctype="multipart/form-data"<BS><ESC>
imap    <Leader>dd     debug(); die();<C-o>2F)
imap    <Leader>dtd     debug($this->data); die();<C-o>2F)
imap    <Leader>bb     {<CR>}<ESC>O
imap    <Leader>bl     <?php  ?><ESC>?p<CR>lli
imap    <Leader>be     <?php echo  ?><ESC>?o<CR>lli
imap    <Leader>ts     $this->set();<ESC>hi
imap    <Leader>md     $this->data;
imap    <Leader>tb     ['']['']<ESC>?[<CR>nlli
imap    <Leader>sb      []
imap    <Leader>sg      []<ESC>i
imap    <Leader>fe      foreach(){<CR>}<ESC>O<ESC>?h<CR>lli
imap    <Leader>fl      for($i=0;$i< ;$i++){<CR>}<ESC>O<ESC>?<<CR>li
imap    <Leader>img    <img src="" alt="" /><ESC>?src<CR>5li
imap    <Leader>ff     <ESC>bdwifunction <ESC>pA<BS>(){<CR>}<ESC>O
vmap    <Leader>link   c<a href="<C-r>""></a><C-o>F<
imap    <Leader>table  <table id="" cellpadding="0" cellspacing="0"><CR></table><ESC>?id<CR>4li
imap    <Leader>div    <div id=""><CR></div><ESC>?id<CR>4li
imap    <Leader>tt      <tr><CR><td></td><CR></tr><ESC>?<td><CR>4li
imap    <Leader>tr      <tr></tr><ESC>4hi<CR><TAB>
imap    <Leader>td      <td></td><ESC>4hi<CR><CR><C-o>k<TAB> 
imap    <Leader>te     $html->tagErrorMsg('');<ESC>?g<CR>3li
imap    <Leader>js     <script type="text/javascript"><CR></script><ESC>O

" Filetypes
au BufNewFile,BufRead *.as set filetype=actionscript
au BufRead,BufNewFile *.thtml   set filetype=php.html
au BufRead,BufNewFile *.php   set filetype=php.html
au BufRead,BufNewFile *.ctp   set filetype=php.html
<<<<<<< HEAD
au BufRead,BufNewFile *.xml   set filetype=xml.html
=======
" Markdown
au BufRead,BufNewFile *.md   set filetype=markdown
au BufRead,BufNewFile *.markdown   set filetype=markdown

>>>>>>> e85ac4ba16688ca4312bc44e736f4ff0e058cb22


" jamessan's smart window/buffer closing functions

function! <SID>ValidAltBuffer(bufnr)
    " &buftype requires +quickfix
    " Checking that it's '' should preclude quickfix, minibufexpl, etc from
    " being considered a valid buffer to switch to
    " bufwinnr() check is to make sure we don't have another window displaying
    " the buffer
    return (!has('quickfix') || getbufvar(a:bufnr, '&buftype') == '') && bufwinnr(a:bufnr) == -1
endfunction

function! <SID>FindBuffer(bufstart, cond, bufend, operand)
    exe "let l:bufnr = a:bufstart " . a:operand . " 1"
    exe "while l:bufnr " . a:cond . " " . a:bufend
        if buflisted(l:bufnr) && <SID>ValidAltBuffer(l:bufnr)
            exe "b " . l:bufnr
            return l:bufnr
        else
            exe "let l:bufnr = l:bufnr " . a:operand . " 1"
        endif
    endwhile
    return a:bufstart
endfunction 
" For all windows/tabpages curbuf is displayed, execute cmd
function! <SID>ExeCmdInAllBufWindows(curbuf, cmd)
    let l:lz = &lz
    let &lz = 1

    let l:tbpgnr = tabpagenr()
    let l:winnr = winnr()
    " Maintain a list of [tabpage, bufinwindow, origwindow]
    let l:buflist = []
    for l:i in range(tabpagenr('$'))
        exe "tabn " . i+1
        let l:nr = winnr()
        for l:j in range(winnr('$'))
            exe l:j+1 . "wincmd w"
            if bufnr('') == a:curbuf
                call add(buflist, [l:i+1, l:j+1, l:nr])
            endif
        endfor
        exe l:nr . "wincmd w"
    endfor

    " For all the [tabpage, bufinwindow, origwindow] sets we have:
    " 1. change to tabpage
    " 2. change to bufinwindow
    " 3. change the buffer (as instructed by a:cmd)
    " 4. put the cursor back in origwindow
    for l:L in l:buflist
        exe "tabn " . l:L[0]
        exe l:L[1] . "wincmd w"
        exe a:cmd
        exe l:L[2] . "wincmd w"
    endfor

    " Change back to our original tabpage and window
    exe "tabn " . l:tbpgnr
    exe l:winnr . "wincmd w"
    let &lz = l:lz
endfunction

function! <SID>CloseIfOnlyWindow(force)
    let l:curbuf = bufnr('%')
    let l:displayedbufs = []
    for i in range(tabpagenr('$'))
        call extend(l:displayedbufs, tabpagebuflist(i+1))
    endfor

    " There is only one buffer being displayed and therefore only one
    " window/tabpage.  We can just delete the buffer
    if len(l:displayedbufs) == 1
        if a:force
            bd!
        else
            bd
        endif
        return
    endif

    let l:bufnr = l:curbuf
    let l:cmd = ''
    if buflisted(bufnr('#')) && <SID>ValidAltBuffer('#')
        let l:bufnr = bufnr('#')
        let l:cmd = 'b ' . l:bufnr
    else
        let l:bufnr = <SID>FindBuffer(l:curbuf, '>', 0, '-')
        if l:bufnr == l:curbuf
            let l:bufnr = <SID>FindBuffer(l:curbuf, '<=', bufnr('$'), '+')
        endif
        if l:bufnr == l:curbuf
            let l:cmd = 'enew'
        else
            let l:cmd = 'b ' . l:bufnr
        endif
    endif

    if count(displayedbufs, l:curbuf) > 1
        call <SID>ExeCmdInAllBufWindows(l:curbuf, l:cmd)
    else
        exe l:cmd
    endif

    if a:force
        exe 'bd! ' . l:curbuf
    else
        exe 'bd ' . l:curbuf
    endif
endfunction

nmap <Leader>bd :call <SID>CloseIfOnlyWindow(0)<CR>
nmap <Leader>bD :call <SID>CloseIfOnlyWindow(1)<CR>


nmap ,r :call ReloadAllSnippets()<CR> 
