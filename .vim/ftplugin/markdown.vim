nnoremap <F12> ggVGgw
" Set column width to something sane since we're writing prose
set textwidth=80
set spell
set spelllang=en_us
" c-f to fix next spelling error
" so you can undo. Found here:
" https://stackoverflow.com/a/16481737
imap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-f> [s1z=<c-o>

" open current buffer in Marked
" Not working yet
" nnoremap <F6> MarkedOpen!
