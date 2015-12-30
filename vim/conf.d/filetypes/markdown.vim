let g:markdown_enable_spell_checking = 0
let g:markdown_mapping_switch_status = '<Learder>x'


function! s:local_markdown()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

augroup settings_markdown
    autocmd!
    autocmd FileType markdown call s:local_markdown()
augroup END
