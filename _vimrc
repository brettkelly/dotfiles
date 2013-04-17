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

"function! WordCount()
  "let s:old_status = v:statusmsg
  "let position = getpos(".")
  "exe ':silent normal g\'
  "let stat = v:statusmsg
  "let s:word_count = 0
  "if stat != '--No lines in buffer--'
    "let s:word_count = str2nr(split(v:statusmsg)[11])
    "let v:statusmsg = s:old_status
  "end
  "call setpos('.', position)
  "return s:word_count 
"endfunction

""" Startup
filetype plugin indent on
filetype on
set nobackup writebackup
set nu
set noswapfile
syntax on

""" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""" Some variables!
let g:author = "Brett Kelly"
let g:email = "brett@brettkelly.org"

""" Visual Suspects
set ts=4 
set sw=4
set tw=0 
set nohlsearch 
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
set laststatus=1
set hidden

" Status Line ---------------------- {{{
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} "  Git Hotness
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
" }}}

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
else
    let g:vimdir = expand("~/.vim/")
    let g:vimrc  = expand("~/.vimrc")
    set ffs=unix,mac,dos
    set backupdir=$HOME/.vim/backup
    set directory=$HOME/.vim/tmp
endif

if has('gui_running')
    set guifont=Consolas:h14
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set bg=dark
    colorscheme jellybeans
else
    colorscheme blue
endif

" Match VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Folding ---------------------- {{{
set foldenable
set foldmethod=marker
set foldlevel=2
set foldcolumn=1
" }}}

" Mappings ---------------------- {{{
" Some mappings to move easily between windows
nmap	<C-h>	<C-w>h
nmap	<C-j>	<C-w>j
nmap	<C-k>	<C-w>k
nmap	<C-l>	<C-w>l

cmap    w!!     %!sudo tee > /dev/null %

" Open current buffer in Marked
nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

" I like emacs-style home and end
imap    <C-a> <Home>
imap    <C-e> <End>
nmap    <C-a> <Home>
nmap    <C-e> <End>
cmap    <C-a> <Home>
cmap    <C-e> <End>
vmap    <C-a> <Home>
vmap    <C-e> <End>

nmap    <F5>    \be  " show buffer list
imap    <F5>    \be

nmap    ,v :e! `=g:vimrc`<CR>   " edit .vimrc
nmap    ,s :source `=g:vimrc`<CR> " :source .vimrc

map <C-n> :NERDTreeToggle<CR> "

" Abbreviations and Mappings
imap    <Leader>bb     {<CR>}<ESC>O  

" }}}

" Filetypes
au BufNewFile,BufRead *.as      set filetype=actionscript
au BufRead,BufNewFile *.thtml   set filetype=php.html
au BufRead,BufNewFile *.php     set filetype=php.html
au BufRead,BufNewFile *.ctp     set filetype=php.html
au BufRead,BufNewFile *.xml     set filetype=xml.html

" Markdown 
au BufRead,BufNewFile,BufEnter *.md   set filetype=markdown 
au BufRead,BufNewFile,BufEnter *.markdown   set filetype=markdown
"autocmd FileType markdown set statusline+=wc:%{WordCount()}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

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
nmap ,S :e ~/.vim/snippets/<CR>

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - 2]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
