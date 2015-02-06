function! s:local_css()
    setlocal ts=4 sts=0 sw=4
endfunction

augroup settings_css
    autocmd!
    autocmd FileType css call s:local_css()
augroup END
