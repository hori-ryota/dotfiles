let g:watchdogs_check_BufWritePost_enable = 1

if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
let g:quickrun_config["watchdogs_checker/_"] = {
            \ "outputter/quickfix/open_cmd": "",
            \ "hook/close_quickfix/enable_exit": 1,
            \ "hook/back_window/enable_exit": 0,
            \ "hook/back_window/priority_exit": 1,
            \ "hook/qfstatusline_update/enable_exit": 1,
            \ "hook/qfstatusline_update/priority_exit": 2,
            \ "runner/vimproc/updatetime": 40,
            \ }

" for go
" gofmtとgovetも実行して混ぜたい->
" 単純に連続実行でできたけど、&区切りの並列実行が上手くいかない
" golintは変数名の指摘だけ無視して混ぜたい
" need `go get github.com/kisielk/errcheck`
let g:quickrun_config["watchdogs_checker/errcheck"] = {
            \ "command": "errcheck",
            \ "exec": "%c -abspath %o ./%s:.:h/...",
            \ "errorformat": '%f:%l:%c: %m, %f:%l:%c %#%m',
            \ }
let g:quickrun_config["watchdogs_checker/go_all"] = {
            \ "command": "go",
            \ "exec": "%c vet %s:p; errcheck -abspath ./%s:.:h/*.go",
            \ "errorformat": '%f:%l:%c: %m, %f:%l:%c %#%m, vet: %.%\+: %f:%l:%c: %m,%W%f:%l: %m',
            \ }
let g:quickrun_config["go/watchdogs_checker"] = {
            \ "type": "watchdogs_checker/errcheck"
            \ }
" let g:quickrun_config["go/watchdogs_checker"] = {
"             \ "type"
"             \     : executable("errcheck") ? "watchdogs_checker/errcheck"
"             \     : executable("gofmt") ? "watchdogs_checker/gofmt"
"             \     : executable("govet") ? "watchdogs_checker/govet"
"             \     : executable("go")    ? "watchdogs_checker/go_vet"
"             \     : ""
"             \ }

" watchdogs.vim の設定を追加
call watchdogs#setup(g:quickrun_config)
" for lightline
let g:Qfstatusline#UpdateCmd = function('lightline#update')
