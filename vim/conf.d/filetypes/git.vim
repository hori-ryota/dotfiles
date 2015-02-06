let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0

nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
nnoremap <silent> ,ga :<C-u>Gwrite<CR>
nnoremap <silent> ,gc :<C-u>Gcommit<CR>
nnoremap <silent> ,gs :<C-u>Gstatus<CR>

augroup Gitv
    autocmd!
    autocmd FileType gitv call s:my_gitv_settings()
    autocmd FileType git setlocal nofoldenable foldlevel=0
augroup END

function! s:gitv_get_current_hash()
    return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

function! s:toggle_gitv_folding()
    if &filetype ==# 'git'
        setlocal foldenable!
    endif
endfunction

function! s:my_gitv_settings()
    setlocal iskeyword+=/,-,.
    nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
    nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=<SID>gitv_get_current_hash()<CR><Space>
    nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=<SID>gitv_get_current_hash()<CR><CR>
    nnoremap <buffer> <Space>h :<C-u>Git cherry-pick <C-r>=<SID>gitv_get_current_hash()<CR><CR>
    nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=<SID>gitv_get_current_hash()<CR>
    nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_gitv_folding()<CR>1<C-w>w
    "" Open current line on GitHub
    noremap ,o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>
endfunction
