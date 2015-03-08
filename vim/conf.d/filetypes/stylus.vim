function! s:local_stylus()
    setlocal ts=4 sts=0 sw=4
endfunction

augroup settings_stylus
    autocmd!
    autocmd FileType stylus call s:local_stylus()
augroup END
