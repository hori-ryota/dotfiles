function! s:local_proto()
    setlocal ts=4 sts=0 sw=4
endfunction

augroup settings_proto
    autocmd!
    autocmd FileType proto call s:local_proto()
augroup END
