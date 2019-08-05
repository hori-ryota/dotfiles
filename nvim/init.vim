let s:script_dir = expand('<sfile>:p:h')
let g:vim_dir = $XDG_CONFIG_HOME . '/nvim'

filetype off
filetype plugin indent off

"{{{ General Config
" set clipboard+=unnamed " Yanks go on clipboard instead
let g:mapleader = 's'
let g:maplocalleader = 's'
" Open vimrc
nnoremap <space>v :<C-u>tabnew <C-r>=$MYVIMRC<CR><CR>:<C-u>CD<CR>
" Reflect vimrc
nnoremap <space>s :<C-u>source <C-r>=$MYVIMRC<CR><CR>
" Character encoding
scriptencoding utf-8
" Automatic end-of-file format detection
set fileformats=unix,mac,dos

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

" move quickfix window to bottom
function! MoveQuickfixWindowToBottom()
    if !getwininfo(win_getid())[0].loclist
        wincmd J
    endif
endfunction
autocmd FileType qf call MoveQuickfixWindowToBottom()
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
set wildmode=longest:full,full
set wildoptions=pum
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

"{{{ Commandline Config
" emacs keybind
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
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
    autocmd BufRead,BufNewFile .envrc                   setfiletype zsh
augroup END
"}}}

"{{{ dein.vim Config

let g:dein#install_progress_type = 'title'
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
    call dein#begin(s:dein_dir)

    let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
    call dein#load_toml(s:toml_file, {})

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

"{{{ Terminal Config
tnoremap <Esc> <C-\><C-n>
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
