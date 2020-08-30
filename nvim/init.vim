let g:vim_dir = $XDG_CONFIG_HOME . '/nvim'

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
"}}}
"{{{ 6 multiple windows
set laststatus=2
"}}}
"{{{ 7 multiple tab pages
"}}}
"{{{ 8 terminal
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
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
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

" modify grep command to ripgrep
if executable('rg')
    let &grepprg = 'rg --vimgrep --no-ignore --glob !.git/ --glob !.DS_Store --glob !node_modules/ --follow --hidden --smart-case'
    set grepformat=%f:%l:%c:%m
endif

"{{{ filetype detect
augroup FileTypeDetect
  autocmd! 
  autocmd BufRead,BufNewFile *.{txt,text}             setfiletype markdown
  autocmd BufRead,BufNewFile *.{snippets,snip}        setfiletype snippets
  autocmd BufRead,BufNewFile .envrc                   setfiletype zsh
  autocmd BufRead,BufNewFile zlogin,zlogout,zpreztorc setfiletype zsh
  autocmd BufRead,BufNewFile zprofile,zshenv,zshrc    setfiletype zsh
augroup END
"}}}

"{{{ dein.vim
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'

let g:dein#install_progress_type = 'title'
let g:dein#install_log_filename = s:dein_dir . '/dein.log'
let g:dein#auto_recache = 1

"{{{ prepare dein.vim
if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    "{{{ install if not exists
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif
    "}}}

    execute 'set runtimepath+=' . s:dein_repo_dir
endif
"}}}

if dein#load_state(s:dein_dir)
  let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
  call dein#begin(s:dein_dir, [expand('<sfile>'), s:toml_file])
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

syntax on
filetype plugin indent on
