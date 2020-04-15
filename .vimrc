" Brett Kelly
" .vimrc
" https://brettkelly.org

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

""" Load plugins via vim-plug
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tomtom/tlib_vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'https://github.com/tpope/vim-surround'
Plug 'garbas/vim-snipmate'
set runtimepath+='~/.vim/snippets/'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'itspriddle/vim-marked'
Plug 'vimwiki/vimwiki'

""""""""""
"" Colors
""""""""""
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'arzg/vim-colors-xcode'
Plug 'phanviet/vim-monokai-pro'
""""""""""
"" The Bench
""""""""""
" Plug 'junegunn/goyo.vim'

call plug#end()

""" Startup
filetype plugin indent on
filetype on
syntax on
set omnifunc=syntaxcomplete#Complete

""" Backups
set backup 
set noswapfile


""" Some variables!
let g:author = "Brett Kelly"
let g:email = "brett@brettkelly.org"
"let g:airline_theme = "jellybeans"

"""" Gist plugin options
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

""" Marked plugin options
let g:marked_filetypes = ["markdown", "md", "mmd"]

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
set linebreak
set smarttab
set completeopt=menu
set laststatus=1
set hidden
set nu
set number relativenumber
set splitbelow splitright
set smartindent
set nocompatible

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

let g:vimdir = expand("~/.vim/")
let g:vimrc  = expand("~/.vimrc")
set ffs=unix,mac,dos
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/tmp

if has('gui_running')
    set guifont=Inconsolata:h16
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set bg=light
    colorscheme badwolf
else
    colorscheme badwolf
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

" copy to system clipboard
vnoremap <C-c> "*y 

cmap    w!!     %!sudo tee > /dev/null %

" FZF key bindings
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }

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
let NERDTreeShowHidden = 1

" I use lots of curly braces.
imap    <Leader>bb     {<CR><CR>}<ESC>ki<TAB>

" Filetypes
au BufRead,BufNewFile *.php     set filetype=php.html

" Enable cursorline in normal mode
autocmd InsertEnter,InsertLeave * set cul! 

" Markdown 
au BufRead,BufNewFile,BufEnter *.md   set filetype=markdown 
au BufRead,BufNewFile,BufEnter *.markdown   set filetype=markdown

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" vimwiki
let g:vimwiki_global_ext=0
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

""""""
" Functions 
""""""

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
