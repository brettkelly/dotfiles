" Duplicated from ftplugin/markdown

nnoremap <F12> ggVGgw
" Set column width to something sane since we're writing prose
set textwidth=80
set spell
set spelllang=en_us
set wrap
set linebreak

" this function is defined elsewhere
nmap <silent> <leader>m :call OpenInMarked2() <CR><CR>
