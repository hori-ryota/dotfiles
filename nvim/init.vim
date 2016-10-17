let s:script_dir = expand('<sfile>:p:h')
let g:vim_dir = $XDG_CONFIG_HOME . '/nvim'

"{{{ General Config
" set clipboard+=unnamed " Yanks go on clipboard instead
let mapleader = ','
let maplocalleader = ','
" Open vimrc
nnoremap <space>v :<C-u>tabnew <C-r>=$MYVIMRC<CR><CR>:<C-u>CD<CR>
" Reflect vimrc
nnoremap <space>s :<C-u>source <C-r>=$MYVIMRC<CR><CR>
" Open dotfiles
nnoremap <space>d :<C-u>tabnew $HOME/.dotfiles/README.md<CR>:<C-u>CD<CR>
" Character encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
" Automatic end-of-file format detection
set fileformats=unix,mac,dos
"}}}

"{{{ Editor Config
set autoindent
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
set ambiwidth=double

set textwidth=0
if v:version >= 703
    set colorcolumn=80
endif
set foldmethod=marker
"}}}

"{{{ Undo/Swap Config
" path
let s:vim_local_dir = g:vim_dir . '.local'
let g:local_backup_dir = s:vim_local_dir . '/backup'
let g:local_swap_dir = s:vim_local_dir . '/swap'
let g:local_undo_dir = s:vim_local_dir . '/undo'

" create necessary directories
if !filewritable(g:local_backup_dir)
    call mkdir(g:local_backup_dir, "p")
endif
if !filewritable(g:local_swap_dir)
    call mkdir(g:local_swap_dir, "p")
endif
if !filewritable(g:local_undo_dir)
    call mkdir(g:local_undo_dir, "p")
endif

" スワップ用のディレクトリ
let &directory = g:local_swap_dir
let &backupdir = g:local_backup_dir

set backup
set writebackup

"" Persistent undo
if has('persistent_undo')
    let &undodir = g:local_undo_dir
    set undofile
endif
"
""}}}

"{{{ UI Config
set ruler                   " show the cursor position all the time
" highlight cursor line in current window
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
    autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
    autocmd WinEnter * call s:auto_cursorline('WinEnter')
    autocmd WinLeave * call s:auto_cursorline('WinLeave')

    let s:cursorline_lock = 0
    function! s:auto_cursorline(event)
        if a:event ==# 'WinEnter'
            setlocal cursorline
            let s:cursorline_lock = 2
        elseif a:event ==# 'WinLeave'
            setlocal nocursorline
        elseif a:event ==# 'CursorMoved'
            if s:cursorline_lock
                if 1 < s:cursorline_lock
                    let s:cursorline_lock = 1
                else
                    setlocal nocursorline
                    let s:cursorline_lock = 0
                endif
            endif
        elseif a:event ==# 'CursorHold'
            setlocal cursorline
            let s:cursorline_lock = 1
        endif
    endfunction
augroup END

highlight clear CursorLine
highlight CursorLine ctermbg=black

set showcmd                     " コマンドの一部を画面下に表示
set number                      " 行番号の表示
set nolazyredraw                " don't redraw while executing macros
set wildmenu                    " turn on wild menu
set wildmode=list:longest,full
set cmdheight=1                 " コマンドライン行を1行に
" カーソルを左右させるキーのうち、ここで指定したものでは、
" カーソルが行頭／末にあるときに前／次行に移動できるようになる。
set whichwrap=b,s,h,l,<,>,[,]
" インサートモードですべて消す
set backspace=indent,eol,start
set shortmess=filtoOA           " shorten messages
set report=0                    " tell us about changes
set nostartofline               " don't jump to the start of line when scrolling
set showmatch                   " brackets/braces that is
set matchtime=3                 " duration to show matching brace (1/10 sec)
set laststatus=2                " The last window always have status line
set scrolloff=5             " Keep at least 5 lines above and below the cursor
set visualbell t_vb=        " No beep sound
" Treat octal and hexadecimal number as decimal number
" octal  Numbers that start with a zero will be considered to be octal
"        Example: Using CTRL-A on "007" results in "010"
" hex    Numbers starting with "0x" or "0X" will be considered to be hexadecimal
"        Example: Using CTRL-X on "0x100" results in "0x0ff"
set nrformats-=octal,hex,alpha
if has("mouse") " Enable the use of the mouse in all modes
    set mouse=a
endif

" フォーカスが移った場合に常にredraw
augroup Redraw
    autocmd!
    autocmd FocusGained * redraw!
augroup END
"}}}

"{{{ Highlight Config
syntax on

" 行末にスペースをハイライト
function! WhiteSpaceEOL()
    highlight WhiteSpaceEOL ctermbg=red guibg=red
endfunction

" 全角文字をハイライト
function! ZenkakuSpace()
    highlight ZenkakuSpace ctermbg=green guibg=green
endfunction

if has('syntax')
    augroup WhiteSpaceEol
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
endif
"}}}

"{{{ Search Config
"" Search
set history=1000            " keep 1000 lines of command line histories
set ignorecase
set smartcase
set wrapscan                " Searches wrap around the end of the file
" While typing a search command, show where the pattern matches
set incsearch
set hlsearch                " highlighting matches
" turn off highlight by Esc x 2
nmap <ESC><ESC> :<C-u>nohlsearch<CR><ESC>
augroup Search
    autocmd!
    autocmd QuickFixCmdPost *grep cwindow
augroup END
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
    autocmd BufRead,BufNewFile *.py                     setfiletype python
    autocmd BufRead,BufNewFile *.scss                   setfiletype scss
    autocmd BufRead,BufNewFile *.styl,*.stylus          setfiletype stylus
    autocmd BufRead,BufNewFile *.tex                    setfiletype tex
    autocmd BufRead,BufNewFile *.tfstate                setfiletype tfstate
    autocmd BufRead,BufNewFile *.toml                   setfiletype toml
    autocmd BufRead,BufNewFile *.ts                     setfiletype typescript
    autocmd BufRead,BufNewFile *.vim                    setfiletype vim
    autocmd BufRead,BufNewFile *.yml,*.yaml,*.lock      setfiletype yaml
    autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*,txt,text} setfiletype markdown
    autocmd BufRead,BufNewFile .tmux.conf,tmux.conf     setfiletype tmux
    autocmd BufRead,BufNewFile Capfile,Gemfile,Rakefile setfiletype ruby
    autocmd BufWinEnter,BufNewFile *_spec.rb            setfiletype ruby.rspec
augroup END
"}}}

"{{{ dein.vim Config

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
    call dein#load_toml(s:toml_file)
    call dein#end()
    call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

"}}}

"{{{ Comment Config
" Commenting blocks of code.
augroup CommentSettings
    autocmd!
    autocmd FileType c,cpp,java,scala,go  set commentstring=//\ %s
    autocmd FileType conf,fstab           set commentstring=#\ %s
    autocmd FileType dot                  set commentstring=//\ %s
    autocmd FileType javascript           set commentstring=//\ %s
    autocmd FileType mail                 set commentstring=>\ %s
    autocmd FileType sh,ruby,python       set commentstring=#\ %s
    autocmd FileType sql                  set commentstring=--\ %s
    autocmd FileType tex                  set commentstring=%\ %s
    autocmd FileType tmux                 set commentstring=#\ %s
    autocmd FileType vim                  set commentstring=\"\ %s
augroup END
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

    nmap <buffer> <Leader>i <Plug>(go-import)
    nnoremap <buffer> <Leader>D :<C-u>GoDrop<space>
    nmap <buffer> <Leader>ii <Plug>(go-imports)
    nnoremap <buffer> <Leader>e :<C-u>GoErrCheck<CR>
    nnoremap <buffer> <Leader>E :<C-u>GoErrCheck ./...<CR>

    nmap <buffer> <Leader>G <Plug>(go-generate)

    nnoremap <buffer> <Leader>p :<C-u>GoPlay<CR>
    vnoremap <buffer> <Leader>p :GoPlay<CR>

    " for ctrlp
    nnoremap <buffer> <C-p>t :<C-u>GoDecls<CR>
    nnoremap <buffer> <C-p>T :<C-u>GoDeclsDir<CR>
endfunction
"}}}

"{{{ javascript

let g:vim_json_syntax_conceal = 0

function! s:setup_javascript()
    nnoremap <buffer> <Leader>gd :<C-u>TernDoc<CR>
    nnoremap <buffer> <Leader>gb :<C-u>TernDocBrowse<CR>
    nnoremap <buffer> <Leader>I :<C-u>TernType<CR>
    nnoremap <buffer> <Leader>dd :<C-u>TernDef<CR>
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
    " nnoremap <buffer> <leader>dd :<C-u>YcmCompleter GoToDefinition<CR>
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

"{{{ filetype configuration
augroup my_setup_filetype_configuration
    autocmd!
    autocmd FileType agit       call s:setup_agit()
    autocmd FileType css        call s:setup_css()
    autocmd FileType dot        call s:setup_dot()
    autocmd FileType go         call s:setup_golang()
    autocmd FileType html       call s:setup_html()
    autocmd FileType javascript call s:setup_javascript()
    autocmd FileType m3u8       call s:setup_m3u8()
    autocmd FileType make       call s:setup_make()
    autocmd FileType markdown   call s:setup_markdown()
    autocmd FileType proto      call s:setup_proto()
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
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
"}}}

"{{{ バイナリ編集(xxd)モード
"[vimでバイナリを表示し、値を変更したい - rderaログ](http://d.hatena.ne.jp/rdera/20081022/1224682665)
"（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
aug roup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END
"}}}

"}}}

" vim: set filetype=vim :
