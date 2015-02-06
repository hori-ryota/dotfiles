function! s:local_scss()
    setlocal ts=4 sts=4 sw=4
endfunction

augroup settings_scss
    autocmd!
    autocmd FileType scss call s:local_scss()
augroup END
