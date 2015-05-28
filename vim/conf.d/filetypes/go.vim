function! s:setup_golang()

    set noexpandtab
    set tabstop=4
    set shiftwidth=4

    inoremap <C-l> :Fmt

    nnoremap <Leader>ff :<C-u>Godoc<Space>
    nnoremap <Leader>dd :exe "Godoc"<CR>

    nmap <Leader>gr <Plug>(go-run)
    nmap <Leader>gi <Plug>(go-info)
    nmap <Leader>gt <Plug>(go-test)
    nmap <Leader>gf <Plug>(go-files)
    nmap <Leader>gd <Plug>(go-def)
    nmap <Leader>gds <Plug>(go-doc-split)
    nmap <Leader>gdv <Plug>(go-doc-vertical)

    autocmd BufWritePre <buffer> Fmt
endfunction

augroup settings_golang
    autocmd!
    autocmd FileType go call s:setup_golang()
augroup END
