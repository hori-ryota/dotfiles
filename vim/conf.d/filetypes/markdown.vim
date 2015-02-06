function! s:local_markdown()
    setlocal tw=0
endfunction

augroup settings_markdown
    autocmd!
    autocmd FileType markdown call s:local_markdown()
augroup END
