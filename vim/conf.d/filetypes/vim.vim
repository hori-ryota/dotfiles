function! s:local_vim()
    setlocal ts=4 sts=4 sw=4
endfunction

augroup settings_vim
    autocmd!
    autocmd FileType vim call s:local_vim()
augroup END
