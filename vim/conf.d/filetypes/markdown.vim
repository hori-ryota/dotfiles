let g:markdown_enable_spell_checking = 0

function! s:local_markdown()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

augroup settings_markdown
    autocmd!
    autocmd FileType markdown call s:local_markdown()
augroup END
