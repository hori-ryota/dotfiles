" vim-go
let g:go_bin_path = expand("~/go/bin")
let $GOROOT = '/usr/local/go'
let $GOPATH = expand("~/go")

function! s:setup_golang()
    inoremap <C-l> fmt

    nnoremap <Leader>ff :<C-u>Godoc<Space>
    nnoremap <Leader>dd :exe "Godoc"<CR>

    nmap <Leader>gr <Plug>(go-run)
    nmap <Leader>gi <Plug>(go-info)
    nmap <Leader>gt <Plug>(go-test)
    nmap <Leader>gf <Plug>(go-files)
    nmap <Leader>gd <Plug>(go-def)
    nmap <Leader>gds <Plug>(go-doc-split)
    nmap <Leader>gdv <Plug>(go-doc-vertical)
endfunction

augroup settings_golang
    autocmd!
    autocmd FileType go call s:setup_golang()
augroup END
