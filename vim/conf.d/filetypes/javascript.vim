function! s:setup_javascript()

    nnoremap <buffer> <Leader>gd <C-u>:TernDoc<CR>
    nnoremap <buffer> <Leader>gv <C-u>:TernDocBrowse<CR>
    nnoremap <buffer> <Leader>tt <C-u>:TernType<CR>
    nnoremap <buffer> <Leader>d <C-u>:TernDef<CR>
    nnoremap <buffer> <Leader>dp <C-u>:TernDefPreview<CR>
    nnoremap <buffer> <Leader>ds <C-u>:TernDefSplit<CR>
    nnoremap <buffer> <Leader>dt <C-u>:TernDefTab<CR>
    nnoremap <buffer> <Leader>dr <C-u>:TernRefs<CR>
    nnoremap <buffer> <Leader>e <C-u>:TernRename<CR>

endfunction

augroup settings_javascript
    autocmd!
    autocmd FileType javascript call s:setup_javascript()
augroup END
