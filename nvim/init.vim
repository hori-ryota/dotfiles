let s:script_dir = expand('<sfile>:p:h')
let g:vim_dir = $XDG_CONFIG_HOME . '/nvim'

filetype off
filetype plugin indent off

"{{{ for debug
command! -bar TimerStart let start_time = reltime()
command! -bar TimerEnd   echom reltimestr(reltime(start_time)) | unlet start_time
" VimShowHlGroup: Show highlight group name under a cursor
command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
" VimShowHlItem: Show highlight item name under a cursor
command! VimShowHlItem echo synIDattr(synID(line("."), col("."), 1), "name")
"}}}

"{{{ General Config
" set clipboard+=unnamed " Yanks go on clipboard instead
let g:mapleader = ','
let g:maplocalleader = ','
" Open vimrc
nnoremap <space>v :<C-u>tabnew <C-r>=$MYVIMRC<CR><CR>:<C-u>CD<CR>
" Reflect vimrc
nnoremap <space>s :<C-u>source <C-r>=$MYVIMRC<CR><CR>
" Open dotfiles
nnoremap <space>d :<C-u>tabnew $HOME/.dotfiles/README.md<CR>:<C-u>CD<CR>
" Character encoding
scriptencoding utf-8
" Automatic end-of-file format detection
set fileformats=unix,mac,dos
" Use pyenv
let g:python_host_prog = expand('$HOME') . '/.pyenv/shims/python'
let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python3'

set timeout
set ttimeout
set ttimeoutlen=10
"}}}

"{{{ Editor Config
set smartindent
set wrap

set tabstop=2
set expandtab
set nosmarttab
set softtabstop=-1 " When 'sts' is negative, the value of 'shiftwidth' is used
set shiftwidth=2
set shiftround

set infercase
set formatoptions+=n
set wrapmargin=0
set virtualedit=block
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,nbsp:%
set nolist

set textwidth=0
if v:version >= 703
    set colorcolumn=80
endif

set completeopt=menuone
"}}}

"{{{ Fold Config
set foldmethod=marker
nnoremap zI :<C-u>set foldmethod=marker<CR>:<C-u>set foldnestmax=20<CR>
nnoremap z<C-i> :<C-u>set foldmethod=indent<CR>:<C-u>set foldnestmax=1<CR>
"}}}

"{{{ Undo/Swap Config
let s:backup_dir = $XDG_DATA_HOME . '/nvim/backup'
set backup
execute 'set backupdir=' . s:backup_dir
set writebackup
set undofile
" create necessary directories
if !filewritable(s:backup_dir)
    call mkdir(s:backup_dir, 'p')
endif
"}}}

"{{{ UI Config
set number                      " 行番号の表示
set nolazyredraw                " don't redraw while executing macros
set wildmode=list:longest,full
set cmdheight=2                 " コマンドライン行を2行に（1行が理想だが、'Shougo/echodoc用に2行にしている）
" カーソルを左右させるキーのうち、ここで指定したものでは、
" カーソルが行頭／末にあるときに前／次行に移動できるようになる。
set whichwrap=b,s,h,l,<,>,[,]
set shortmess=filtoOA           " shorten messages
set report=0                    " tell us about changes
set nostartofline               " don't jump to the start of line when scrolling
set showmatch                   " brackets/braces that is
set matchtime=3                 " duration to show matching brace (1/10 sec)
set scrolloff=5                 " Keep at least 5 lines above and below the cursor
set visualbell t_vb=            " No beep sound
if has('mouse') " Enable the use of the mouse in all modes
    set mouse=a
endif
"}}}

"{{{ Highlight Config
" 行末にスペースをハイライト
function! WhiteSpaceEOL()
    highlight WhiteSpaceEOL ctermbg=red guibg=red
endfunction

" 全角文字をハイライト
function! ZenkakuSpace()
    highlight ZenkakuSpace ctermbg=green guibg=green
endfunction

augroup WhiteSpaceEOL
    autocmd!
    autocmd ColorScheme       * call WhiteSpaceEOL()
    autocmd VimEnter,WinEnter * match WhiteSpaceEOL /\s\+$/
augroup END
call WhiteSpaceEOL()
augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END
call ZenkakuSpace()
"}}}

"{{{ Search Config
"" Search
set ignorecase
set smartcase
" turn off highlight by Esc x 2
nmap <ESC><ESC> :<C-u>nohlsearch<CR><ESC>
augroup Search
    autocmd!
    autocmd QuickFixCmdPost *grep cwindow
augroup END
"}}}

"{{{ shows interactive results
set inccommand=split
"}}}

"{{{ FileTypeDetect
augroup FileTypeDetect
    autocmd!
    autocmd BufRead,BufNewFile *.PL,*.psgi,*.t          setfiletype perl
    autocmd BufRead,BufNewFile *.coffee                 setfiletype coffee
    autocmd BufRead,BufNewFile *.go                     setfiletype go
    autocmd BufRead,BufNewFile *.hatena                 setfiletype markdown
    autocmd BufRead,BufNewFile *.html                   setfiletype html
    autocmd BufRead,BufNewFile *.jade                   setfiletype jade
    autocmd BufRead,BufNewFile *.java                   setfiletype java
    autocmd BufRead,BufNewFile *.json,*.gyp,*.js        setfiletype javascript
    autocmd BufRead,BufNewFile *.kt                     setfiletype kotlin
    autocmd BufRead,BufNewFile *.less                   setfiletype less
    autocmd BufRead,BufNewFile *.m3u8                   setfiletype m3u8
    autocmd BufRead,BufNewFile *.pp                     setfiletype puppet
    autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml    setfiletype plantuml
    autocmd BufRead,BufNewFile *.py                     setfiletype python
    autocmd BufRead,BufNewFile *.scss                   setfiletype scss
    autocmd BufRead,BufNewFile *.snippets,*.snip        setfiletype snippets
    autocmd BufRead,BufNewFile *.styl,*.stylus          setfiletype stylus
    autocmd BufRead,BufNewFile *.tex                    setfiletype tex
    autocmd BufRead,BufNewFile *.tfstate                setfiletype tfstate
    autocmd BufRead,BufNewFile *.toml                   setfiletype toml
    autocmd BufRead,BufNewFile *.ts                     setfiletype typescript
    autocmd BufRead,BufNewFile *.vim                    setfiletype vim
    autocmd BufRead,BufNewFile *.yml,*.yaml,*.lock      setfiletype yaml
    autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*,txt,text} setfiletype markdown
    autocmd BufRead,BufNewFile *_spec.rb                setfiletype ruby.rspec
    autocmd BufRead,BufNewFile .tmux.conf,tmux.conf     setfiletype tmux
    autocmd BufRead,BufNewFile Capfile,Gemfile,Rakefile setfiletype ruby
augroup END
"}}}

"{{{ dein.vim Config

let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let g:dein#install_log_filename = '~/dein.log'

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir   = s:cache_home . '/dein'
if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif

    execute 'set runtimepath+=' . s:dein_repo_dir
endif
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, expand('<sfile>'))

    let s:toml_file      = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
    let s:lazy_toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
    call dein#load_toml(s:toml_file,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml_file, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

if !has('vim_starting')
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif

"}}}

"{{{ Comment Config
" Commenting blocks of code.
augroup CommentSettings
    autocmd!
    autocmd FileType c,cpp,java,scala,go  setlocal commentstring=//\ %s
    autocmd FileType conf,fstab           setlocal commentstring=#\ %s
    autocmd FileType dot                  setlocal commentstring=//\ %s
    autocmd FileType javascript           setlocal commentstring=//\ %s
    autocmd FileType mail                 setlocal commentstring=>\ %s
    autocmd FileType sh,ruby,python       setlocal commentstring=#\ %s
    autocmd FileType sql                  setlocal commentstring=--\ %s
    autocmd FileType tex                  setlocal commentstring=%\ %s
    autocmd FileType tmux                 setlocal commentstring=#\ %s
    autocmd FileType vim                  setlocal commentstring=\"\ %s
augroup END
"}}}

"{{{ Terminal Config
tnoremap <Esc> <C-\><C-n>
"}}}

"{{{ File Type Config

"{{{ html
function! s:setup_html()
endfunction
"}}}

"{{{ css
function! s:setup_css()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ git
" TODO: fold level
let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0
let g:fugitive_github_domains = ['[^/]*']

nnoremap <silent> <space>g :<C-u>Git<space>
nnoremap <silent> <space>ga :<C-u>Gwrite<CR>
nnoremap <silent> <space>gc :<C-u>Gcommit<CR>
nnoremap <silent> <space>gs :<C-u>Gstatus<CR>
nnoremap <silent> <space>gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> <space>gh :<C-u>GitGutterLineHighlightsToggle<CR>
nnoremap <silent> <space>gr :<C-u>Gbrowse<CR>
nnoremap <silent> <space>gd :<C-u>Gdiff<CR>
nnoremap <silent> <space>gbl :<C-u>Gblame<CR>

nnoremap <silent> <space>gl :<C-u>Agit<CR>
nnoremap <silent> <space>gL :<C-u>AgitFile<CR>

function! s:setup_agit()
    nmap <buffer> ch <Plug>(agit-git-cherry-pick)
    nmap <buffer> Rv <Plug>(agit-git-revert)
endfunction

nnoremap <silent> <space>gm :<C-u>MerginalToggle<CR>
"}}}

"{{{ go

function! s:setup_golang()

    nmap <buffer> <leader>r <Plug>(go-run)
    " nmap <buffer> <leader>b <Plug>(go-build)
    nmap <buffer> <leader>b :<C-u>make<CR>
    nmap <buffer> <leader>t <Plug>(go-test)
    nmap <buffer> <leader>c <Plug>(go-coverage-toggle)
    nmap <buffer> <leader>T <Plug>(go-test-func)

    nmap <buffer> <Leader>gd <Plug>(go-doc)
    nmap <buffer> <Leader>gs <Plug>(go-doc-split)
    nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
    nmap <buffer> <Leader>gb <Plug>(go-doc-browser)
    nmap <buffer> <Leader>gt <Plug>(go-doc-tab)

    nmap <buffer> <Leader>dd <Plug>(go-def)
    nmap <buffer> <C-]> <Plug>(go-def)
    nmap <buffer> <Leader>ds <Plug>(go-def-split)
    nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
    nmap <buffer> <Leader>dt <Plug>(go-def-tab)

    nmap <buffer> <Leader>ad <Plug>(go-alternate-edit)
    nmap <buffer> <Leader>as <Plug>(go-alternate-split)
    nmap <buffer> <Leader>av <Plug>(go-alternate-vertical)

    nmap <buffer> <Leader>de <Plug>(go-describe)
    nmap <buffer> <Leader>dc <Plug>(go-callers)
    nmap <buffer> <Leader>dr <Plug>(go-referrers)
    nmap <buffer> <Space>d :<C-u>Denite decls:%<CR>
    nmap <buffer> <Space>D :<C-u>Denite decls<CR>

    nmap <buffer> <Leader>s <Plug>(go-implements)

    nmap <buffer> <Leader>I <Plug>(go-info)

    nmap <buffer> <Leader>R <Plug>(go-rename)

    nmap <buffer> <Leader>v <Plug>(go-vet)
    nmap <buffer> <Leader>m <Plug>(go-metalinter)
    nnoremap <buffer> <Leader>M :<C-u>GoMetaLinter ./...<CR>

    nmap <buffer> <Leader>i <Plug>(go-import)
    nnoremap <buffer> <Leader>D :<C-u>GoDrop<space>
    nmap <buffer> <Leader>ii <Plug>(go-imports)
    nnoremap <buffer> <Leader>e :<C-u>GoErrCheck<CR>
    nnoremap <buffer> <Leader>E :<C-u>GoErrCheck ./...<CR>

    nmap <buffer> <Leader>G <Plug>(go-generate)

    nnoremap <buffer> <Leader>p :<C-u>GoPlay<CR>
    vnoremap <buffer> <Leader>p :GoPlay<CR>

endfunction
"}}}
"
"{{{ java
function! s:setup_java()
    let g:LanguageClient_diagnosticsEnable = 0
    nnoremap <buffer> K :<C-u>call LanguageClient_textDocument_hover()<CR>
    nnoremap <buffer> <C-]> :<C-u>call LanguageClient_textDocument_definition()<CR>
    nnoremap <buffer> <Leader>R :<C-u>call LanguageClient_textDocument_rename()<CR>
endfunction
"}}}

"{{{ javascript

let g:vim_json_syntax_conceal = 0

function! s:setup_javascript()
    nnoremap <buffer> <Leader>gd :<C-u>TernDoc<CR>
    nnoremap <buffer> <Leader>gb :<C-u>TernDocBrowse<CR>
    nnoremap <buffer> <Leader>I :<C-u>TernType<CR>
    nnoremap <buffer> <Leader>dd :<C-u>TernDef<CR>
    nnoremap <buffer> <C-]> :<C-u>TernDef<CR>
    nnoremap <buffer> <Leader>dp :<C-u>TernDefPreview<CR>
    nnoremap <buffer> <Leader>ds :<C-u>TernDefSplit<CR>
    nnoremap <buffer> <Leader>dt :<C-u>TernDefTab<CR>
    nnoremap <buffer> <Leader>de :<C-u>TernRefs<CR>
    nnoremap <buffer> <Leader>R :<C-u>TernRename<CR>
endfunction
"}}}

"{{{ make
function! s:setup_make()
    setlocal noexpandtab
    setlocal tabstop=8
    setlocal shiftwidth=8
endfunction
"}}}

"{{{ markdown
function! s:setup_markdown()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ proto
function! s:setup_proto()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}
"
"{{{ python
function! s:setup_python()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ scss
function! s:setup_scss()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ stylus
function! s:setup_stylus()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ typescript
function! s:setup_typescript()
    nnoremap <buffer> <C-]> :<C-u>TSDef<CR>
    nnoremap <buffer> <Leader>dp :<C-u>TSDefPreview<CR>
    nnoremap <buffer> <Leader>dr :<C-u>TSRefs<CR>
    nnoremap <buffer> K :<C-u>TSDoc<CR>
    nnoremap <buffer> <Leader>I :<C-u>TSType<CR>
    nnoremap <buffer> <Leader>ii :<C-u>TSImport<CR>
endfunction
"}}}

"{{{ vim
function! s:setup_vimscript()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ snippets
function! s:setup_snippets()
    setlocal noexpandtab
endfunction
"}}}

"{{{ revealjs
function! s:setup_revealjs()
    nnoremap <buffer> <Leader>b :<C-u>!npm run build<CR>
    nnoremap <buffer> <Leader>r :<C-u>!npm run start<CR>
    nnoremap <buffer> <Leader>t :<C-u>!npm run test<CR>
endfunction
"}}}

"{{{ talkiejs
function! s:setup_talkiejs()
    nnoremap <buffer> <Leader>b :<C-u>!npm run build<CR>
    nnoremap <buffer> <Leader>r :<C-u>!npm run start<CR>
    nnoremap <buffer> <Leader>w :<C-u>!npm run d<CR>
    nnoremap <buffer> <Leader>t :<C-u>!npm run test<CR>
endfunction
"}}}

"{{{ m3u8
function! s:setup_m3u8()
endfunction
"}}}

"{{{ dot
function! s:setup_dot()
    nnoremap <silent> <buffer> <LocalLeader>lp :GraphvizCompilePDF<CR>
endfunction
"}}}

"{{{ plantuml
function! s:setup_plantuml()
    command! OpenUml :!start chrome %
    nnoremap <silent> <buffer> <LocalLeader>b :make<CR>
    nnoremap <silent> <buffer> <LocalLeader>r :OpenUml<CR>
endfunction
"}}}

"{{{ filetype configuration
augroup my_setup_filetype_configuration
    autocmd!
    autocmd FileType agit       call s:setup_agit()
    autocmd FileType css        call s:setup_css()
    autocmd FileType dot        call s:setup_dot()
    autocmd FileType go         call s:setup_golang()
    autocmd FileType html       call s:setup_html()
    autocmd FileType java       call s:setup_java()
    autocmd FileType javascript call s:setup_javascript()
    autocmd FileType m3u8       call s:setup_m3u8()
    autocmd FileType make       call s:setup_make()
    autocmd FileType markdown   call s:setup_markdown()
    autocmd FileType plantuml   call s:setup_plantuml()
    autocmd FileType proto      call s:setup_proto()
    autocmd FileType python     call s:setup_python()
    autocmd FileType revealjs   call s:setup_revealjs()
    autocmd FileType scss       call s:setup_scss()
    autocmd FileType snippets   call s:setup_snippets()
    autocmd FileType stylus     call s:setup_stylus()
    autocmd FileType talkiejs   call s:setup_talkiejs()
    autocmd FileType typescript call s:setup_typescript()
    autocmd FileType vim        call s:setup_vimscript()
augroup END
"}}}

"}}}

"{{{ vimdiff
set diffopt+=vertical
if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif
"}}}

"{{{ Personal Script

"{{{ Change current directory easily
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory ==? ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang ==? ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
"}}}

"}}}

"{{{ local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
"}}}

filetype plugin indent on
syntax enable

" vim: set filetype=vim :
