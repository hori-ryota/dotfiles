function! s:local_css()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

augroup settings_css
    autocmd!
    autocmd FileType css call s:local_css()
augroup END
