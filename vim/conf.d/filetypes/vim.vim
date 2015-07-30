function! s:local_vim()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

augroup settings_vim
    autocmd!
    autocmd FileType vim call s:local_vim()
augroup END
