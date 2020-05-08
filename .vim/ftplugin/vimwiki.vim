"" Duplicated from ftplugin/markdown

"nnoremap <F12> ggVGgw
"set spell
"set spelllang=en_us

"" this function is defined elsewhere
"nmap <silent> <leader>m :call OpenInMarked2() <CR><CR>

" We use Markdown in these parts, so just include the same mappings and
" settings that we use for that format.
runtime markdown.vim
