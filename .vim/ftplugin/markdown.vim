set spell
set spelllang=en_us
set nolist

" F10 corrects the most recent misspelling with the first option because the
" first option is probably the right one. Works in normal and insert mode
imap <F10> <Esc>[s1z=`]a
nmap <F10> [s1z=`]
nnoremap <F12> ggVGgw
" Preview the file in Marked 
nmap <silent> <leader>m :call OpenInMarked2() <CR><CR>
