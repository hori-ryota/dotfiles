let g:watchdogs_check_BufWritePost_enable = 1

if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
let g:quickrun_config["watchdogs_checker/_"] = {
            \ "outputter/quickfix/open_cmd": "",
            \ "hook/qfstatusline_update/enable_exit": 1,
            \ "hook/qfstatusline_update/priority_exit": 4,
            \ "runner/vimproc/updatetime": 40,
            \ }

" for go
" TODO: errcheck対応の修正。gopathからのpathで出力されるのでerrformatが上手くいかない
" こっちにしたい "errorformat": '%f:%l:%c: %m, %f:%l:%c %#%m, %-G%.%#',
" gopathからcurrentDirのパスをerrorformatに入れられればいいのだけども
" gofmtとgovetも実行して混ぜたい->
" 単純に連続実行でできたけど、&区切りの並列実行が上手くいかない
" golintは変数名の指摘だけ無視して混ぜたい
" need `go get github.com/kisielk/errcheck`
let g:quickrun_config["watchdogs_checker/errcheck"] = {
            \ "command": "errcheck",
            \ "exec": "%c %o %s:p",
            \ "errorformat": '%f:%l:%c: %m, %-G%.%#',
            \ }
" errcheckの出力がparseできてないのでとりあえずerrorformatでは無視せずにquickfixにはメモ書きで入れとく
let g:quickrun_config["watchdogs_checker/go_all"] = {
            \ "command": "go",
            \ "exec": "%c vet %s:p; errcheck ./%s:.:h/...",
            \ "errorformat": '%f:%l:%c: %m, vet: %.%\+: %f:%l:%c: %m,%W%f:%l: %m',
            \ }
" errcheckがvendor未対応なのでいったんbuildとvetに
let g:quickrun_config["watchdogs_checker/go_build"] = {
            \ "command": "go",
            \ "exec": "%c vet %s:p; %c build %s:p",
            \ "errorformat": '%f:%l:%c: %m, vet: %.%\+: %f:%l:%c: %m,%W%f:%l: %m',
            \ }
let g:quickrun_config["go/watchdogs_checker"] = {
            \ "type": "watchdogs_checker/go_build"
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
