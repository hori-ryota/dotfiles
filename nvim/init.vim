let g:vim_dir = $XDG_CONFIG_HOME . '/nvim'
let g:python3_host_prog = $HOME . '/.asdf/shims/python'

"{{{ Options
" see `:options`

"{{{ 1 important
"}}}
"{{{ 2 moving around, searching and patterns
set wrapscan
set incsearch
set ignorecase
set smartcase
"}}}
"{{{ 3 tags
"}}}
"{{{ 4 displaying text
set scrolloff=5
set lazyredraw
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,nbsp:%
set nolist
set number
"}}}
"{{{ 5 syntax, highlighting and spelling
set hlsearch
nohlsearch
set spell
set spellcapcheck=
set spelloptions=camel
set spelllang+=cjk
let s:spellfile_dir = $XDG_CONFIG_HOME . '/nvim/spell'
if !isdirectory(s:spellfile_dir)
    call mkdir(s:spellfile_dir, 'p')
endif
let &spellfile = s:spellfile_dir . '/en.utf-8.add'
"}}}
"{{{ 6 multiple windows
set laststatus=2
set nohidden
"}}}
"{{{ 7 multiple tab pages
"}}}
"{{{ 8 terminal
set sh=zsh
tnoremap <silent> <ESC> <C-\><C-n>
"}}}
"{{{ 9 using the mouse
"}}}
"{{{ 10 printing
"}}}
"{{{ 11 messages and info
"}}}
"{{{ 12 selecting text
"}}}
"{{{ 13 editing text
set undofile
set completeopt=menuone
set formatoptions-=o
set infercase
set matchpairs+=<:>,「:」
"}}}
"{{{ 14 tabs and indenting
set tabstop=2
set shiftwidth=2
set shiftround
set nosmarttab
set expandtab
set autoindent
"}}}
"{{{ 15 folding
set foldmethod=marker
"}}}
"{{{ 16 diff mode
set diffopt+=vertical
set diffopt+=algorithm:histogram
"}}}
"{{{ 17 mapping
set ttimeoutlen=10
"}}}
"{{{ 18 reading and writing files
set fileformats=unix,mac,dos
"}}}
"{{{ 19 the swap file
"}}}
"{{{ 20 command line editing
set wildmode=longest:full,full
set wildoptions=pum
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
"}}}
"{{{ 21 executing external commands
"}}}
"{{{ 22 running make and jumping to errors
" modify grep command to ripgrep
if executable('rg')
    let &grepprg = 'rg --vimgrep'
    set grepformat=%f:%l:%c:%m
endif
"}}}
"{{{ 23 language specific
"}}}
"{{{ 24 multi-byte characters
set fileencodings=utf-8,sjis
"}}}
"{{{ 25 various
set sessionoptions+=winpos
"}}}
"}}}

let g:mapleader = 's'
let g:maplocalleader = 's'

nnoremap <Leader>S :<C-u>source $MYVIMRC<CR>

" turn off highlight
" close preview window
nnoremap <silent> <ESC> :<C-u>nohlsearch<CR>:pclose<CR>

" close quickfix window
" close location list
nnoremap <silent> g<ESC> :<C-u>nohlsearch<CR>:pclose<CR>:cclose<CR>:lclose<CR>

" move quickfix window to bottom
function! MoveQuickfixWindowToBottom()
    if !getwininfo(win_getid())[0].loclist
        wincmd J
    endif
endfunction
autocmd FileType qf call MoveQuickfixWindowToBottom()

"{{{ filetype detect
augroup FileTypeDetect
  autocmd! 
  autocmd BufRead,BufNewFile *.{txt,text}             setfiletype markdown
  autocmd BufRead,BufNewFile *.marp.md                setfiletype markdown.marp
  autocmd BufRead,BufNewFile *.csv                    setfiletype csv
  autocmd BufRead,BufNewFile *.{snippets,snip}        setfiletype snippets
  autocmd BufRead,BufNewFile .envrc                   setfiletype zsh
  autocmd BufRead,BufNewFile .env,.env.*              setfiletype zsh
  autocmd BufRead,BufNewFile zlogin,zlogout,zpreztorc setfiletype zsh
  autocmd BufRead,BufNewFile zprofile,zshenv,zshrc    setfiletype zsh
  autocmd BufRead,BufNewFile *.go.y                   setfiletype goyacc
  autocmd BufRead,BufNewFile *.uml                    setfiletype plantuml
  autocmd BufRead,BufNewFile *.vim.local              setfiletype vim
  autocmd BufRead,BufNewFile *Dockerfile*             setfiletype Dockerfile
  autocmd BufRead,BufNewFile tsconfig.json,tsconfig.*.json,.eslintrc,.eslintrc.json setfiletype jsonc
augroup END
"}}}

"{{{ dein.vim
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:dein_dir = s:cache_home . '/dein'

let g:dein#install_progress_type = 'title'
let g:dein#auto_recache = 1
let g:dein#install_log_filename = g:dein_dir . '/dein.log'

"{{{ prepare dein.vim
if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = g:dein_dir . '/repos/github.com/Shougo/dein.vim'
    "{{{ install if not exists
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif
    "}}}

    execute 'set runtimepath^=' . s:dein_repo_dir
endif
"}}}

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:config_files = [
        \ expand('<sfile>'),
        \ s:toml_file,
        \ ]
if dein#load_state(g:dein_dir)
  call dein#begin(g:dein_dir, s:config_files)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
call dein#call_hook('source')
augroup DeinHooks
  autocmd!
  autocmd VimEnter * ++nested call dein#call_hook('post_source')
augroup END
"}}}

"{{{ custom highlight
highlight link FloatBorder NormalFloat
"}}}

let s:local_initvim_files = findfile('.init.vim.local', escape(getcwd(), ' ') . ';', -1)
for i in reverse(filter(s:local_initvim_files, 'filereadable(v:val)'))
  source `=i`
endfor

syntax on
filetype plugin indent on
