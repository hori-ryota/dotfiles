function! s:setup_golang()

    nmap <buffer> <leader>r <Plug>(go-run)
    nmap <buffer> <leader>b <Plug>(go-build)
    nmap <buffer> <leader>t <Plug>(go-test)
    nmap <buffer> <leader>c <Plug>(go-coverage)

    nmap <buffer> <Leader>d <Plug>(go-def)
    nmap <buffer> <Leader>ds <Plug>(go-def-split)
    nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
    nmap <buffer> <Leader>dt <Plug>(go-def-tab)

    nmap <buffer> <Leader>gd <Plug>(go-doc)
    nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
    nmap <buffer> <Leader>gb <Plug>(go-doc-browser)
    nmap <buffer> <Leader>gt <Plug>(go-doc-tab)

    nmap <buffer> <Leader>s <Plug>(go-implements)

    nmap <buffer> <Leader>i <Plug>(go-info)

    nmap <buffer> <Leader>e <Plug>(go-rename)

    nnoremap <buffer> <Leader>I <C-u>:GoImport<space>
    nnoremap <buffer> <Leader>D <C-u>:GoDrop<space>
    nnoremap <buffer> <Leader>II <C-u>:GoImports<CR>

endfunction

augroup settings_golang
    autocmd!
    autocmd FileType go call s:setup_golang()
augroup END
