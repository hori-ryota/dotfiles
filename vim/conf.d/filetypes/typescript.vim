function! s:setup_typescript()
    nnoremap <buffer> <leader>dd :<C-u>YcmCompleter GoToDefinition<CR>
endfunction

augroup settings_typescript
    autocmd!
    autocmd FileType typescript call s:setup_typescript()
augroup END
