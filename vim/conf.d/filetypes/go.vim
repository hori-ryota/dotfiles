let g:go_fmt_options = '-s'
" metalinterにオプションを付ける方法が用意されていなかったのでとりあえず無理やり混ぜ込む
let g:go_metalinter_deadline = '10s --tests'
let g:go_metalinter_enabled = [
            \ 'aligncheck',
            \ 'deadcode',
            \ 'errcheck',
            \ 'gofmt',
            \ 'ineffassign',
            \ 'interfacer',
            \ 'structcheck',
            \ 'varcheck',
            \ 'vet',
            \ ]
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }

function! s:setup_golang()

    nmap <buffer> <leader>r <Plug>(go-run)
    nmap <buffer> <leader>b <Plug>(go-build)
    nmap <buffer> <leader>t <Plug>(go-test)
    nmap <buffer> <leader>c <Plug>(go-coverage)
    nmap <buffer> <leader>T <Plug>(go-test-func)

    nmap <buffer> <Leader>gd <Plug>(go-doc)
    nmap <buffer> <Leader>gs <Plug>(go-doc-split)
    nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
    nmap <buffer> <Leader>gb <Plug>(go-doc-browser)
    nmap <buffer> <Leader>gt <Plug>(go-doc-tab)

    nmap <buffer> <Leader>dd <Plug>(go-def)
    nmap <buffer> <Leader>ds <Plug>(go-def-split)
    nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
    nmap <buffer> <Leader>dt <Plug>(go-def-tab)

    nmap <buffer> <Leader>ad <Plug>(go-alternate-edit)
    nmap <buffer> <Leader>as <Plug>(go-alternate-split)
    nmap <buffer> <Leader>av <Plug>(go-alternate-vertical)

    nmap <buffer> <Leader>de <Plug>(go-describe)
    nmap <buffer> <Leader>dc <Plug>(go-callers)
    nmap <buffer> <Leader>dr <Plug>(go-referrers)

    nmap <buffer> <Leader>s <Plug>(go-implements)

    nmap <buffer> <Leader>I <Plug>(go-info)

    nmap <buffer> <Leader>R <Plug>(go-rename)

    nmap <buffer> <Leader>v <Plug>(go-vet)
    nmap <buffer> <Leader>m <Plug>(go-metalinter)
    nnoremap <buffer> <Leader>M :<C-u>GoMetaLinter ./...<CR>

    nnoremap <buffer> <Leader>i :<C-u>GoImport<space>
    nnoremap <buffer> <Leader>D :<C-u>GoDrop<space>
    nnoremap <buffer> <Leader>ii :<C-u>GoImports<CR>
    nnoremap <buffer> <Leader>e :<C-u>GoErrCheck<CR>
    nnoremap <buffer> <Leader>E :<C-u>GoErrCheck ./...<CR>

    nnoremap <buffer> <Leader>p :<C-u>GoPlay<CR>
    vnoremap <buffer> <Leader>p :GoPlay<CR>

endfunction

augroup settings_golang
    autocmd!
    autocmd FileType go call s:setup_golang()
augroup END

