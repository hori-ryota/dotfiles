let s:script_dir = expand('<sfile>:p:h')
let g:vim_dir = $XDG_CONFIG_HOME . '/nvim'

"{{{ General Config
" set clipboard+=unnamed " Yanks go on clipboard instead
let mapleader = ','
let maplocalleader = ','
" Open vimrc
nnoremap <space>v :<C-u>tabnew <C-r>$MYVIMRC<CR>:<C-u>CD<CR>
" Reflect vimrc
nnoremap <space>s :<C-u>source <C-r>$MYVIMRC<CR>
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
    autocmd BufRead,BufNewFile *.ts                     setfiletype typescript
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

"{{{ Plugin Config

"{{{ ctrlp
" Default mappings
"" let g:ctrlp_map = '<C-p>'
"" let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_map = '<C-p><C-p>'

let g:ctrlp_working_path_mode = 'wa'

let g:ctrlp_match_window = 'max:50'

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --ignore ''Alfred.alfredpreferences'' --hidden -g ""'
endif

nnoremap <C-p>p :<C-u>CtrlP<CR>
nnoremap <C-p>b :<C-u>CtrlPBuffer<CR>
nnoremap <C-p>m :<C-u>CtrlPMRU<CR>
nnoremap <C-p>T :<C-u>CtrlPTag<CR>
nnoremap <C-p>t :<C-u>CtrlPBufTag<CR>
nnoremap <C-p>q :<C-u>CtrlPQuickfix<CR>
nnoremap <C-p>d :<C-u>CtrlPDir<CR>
nnoremap <C-p>r :<C-u>CtrlPPTS<CR>
nnoremap <C-p>u :<C-u>CtrlPUndo<CR>
nnoremap <C-p>l :<C-u>CtrlPLine<CR>
nnoremap <C-p>c :<C-u>CtrlPChange<CR>
nnoremap <C-p>x :<C-u>CtrlPMixed<CR>
nnoremap <C-p>y :<C-u>CtrlPYankRound<CR>
"}}}

"{{{ diffcher
let g:DiffUnit = "Word1"
"}}}

"{{{ emmet-vim
let g:user_emmet_leader_key=','

let g:user_emmet_settings = {
            \   'variables': {
            \     'lang': 'ja'
            \   },
            \   'indentation': '  '
            \ }
"}}}

"{{{ gundo
nnoremap <space>u :<C-u>GundoToggle<CR>
"}}}

"{{{ indentLine
let g:indentLine_color_term = 236
"}}}

"{{{ lightline
let g:lightline = {
            \ 'colorscheme': 'hybrid',
            \ 'mode_map': { 'c': 'NORMAL' },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
            \   'right': [ [ 'qfstatusline', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightLineFugitive',
            \   'filename': 'LightLineFilename',
            \   'fileformat': 'LightLineFileformat',
            \   'filetype': 'LightLineFiletype',
            \   'fileencoding': 'LightLineFileencoding',
            \   'mode': 'LightLineMode',
            \   'ctrlpmark': 'CtrlPMark',
            \ },
            \ 'component_expand': {
            \   'qfstatusline': 'qfstatusline#Update',
            \ },
            \ 'component_type': {
            \   'qfstatusline': 'error',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
"}}}

"{{{ memolist
let g:memolist_path = "~/Dropbox/memo"
" suffix type (default markdown)
let g:memolist_memo_suffix = "txt"

" date format (default %Y-%m-%d %H:%M)
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
"" let g:memolist_memo_date = "epoch"
"" let g:memolist_memo_date = "%D %T"

" tags prompt (default 0)
"" let g:memolist_prompt_tags = 1

" categories prompt (default 0)
let g:memolist_prompt_categories = 1

" use qfixgrep (default 0)
let g:memolist_qfixgrep = 1

" use vimfler (default 0)
"" let g:memolist_vimfiler = 1

" use arbitrary vimfler option (default -split -winwidth=50)
"" let g:memolist_vimfiler_option = "-split -winwidth=50 -simple"

" use unite (default 0)
"" let g:memolist_unite = 1

" use arbitrary unite option (default is empty)
"" let g:memolist_unite_option = "-auto-preview -start-insert"

" use arbitrary unite source (default is 'file')
"" let g:memolist_unite_source = "file_rec"

" use template
let g:memolist_template_dir_path = "~/.vim/template/memolist"

" remove filename prefix (default 0)
"" let g:memolist_filename_prefix_none = 1

" use various Ex commands (default '')
let g:memolist_ex_cmd = 'CtrlP'
let g:memolist_ex_cmd = 'NERDTree'

nnoremap <Leader>mn :<C-u>MemoNew<CR>
nnoremap <Leader>ml :<C-u>MemoList<CR>
nnoremap <Leader>mg :<C-u>MemoGrep<CR>
" use CtrlP
nnoremap <Leader>mf :<C-u>exe "CtrlP" g:memolist_path<cr><f5>
"}}}

"{{{ NERDTree
nnoremap <silent> <space>e :<C-u>NERDTreeToggle<CR>
let g:NERDTreeMinimalUI=1
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"}}}

"{{{ plantuml-syntax
let g:plantuml_executable_script = '~/.dotfiles/plantuml.sh'
"}}}

"{{{ Previm
" realtime preview
let g:previm_enable_realtime = 1
"}}}

"{{{ tagbar
nmap <space>t :<C-u>TagbarToggle<CR>
"}}}

"{{{ tern_for_vim
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
"}}}

"{{{ UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = '<c-k>'
let g:UltiSnipsJumpForwardTrigger = '<c-k>'
let g:UltiSnipsJumpBackwardTrigger = '<c-j>'
let g:UltiSnipsListSnippets = '<c-l>'
let g:UltiSnipsSnippetsDir = g:vim_dir . '/UltiSnips'
let g:UltiSnipsEditSplit = 'context'
"}}}

"{{{ vim-choosewin 
" invoke with '-'
nmap  -  <Plug>(choosewin)

" use overlay feature
let g:choosewin_overlay_enable = 1

" workaround for overlay font broken on mutibyte buffer.
let g:choosewin_overlay_clear_multibyte = 1

" tmux like overlay color
let g:choosewin_color_overlay = {
            \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
            \ 'cterm': [ 25, 25 ]
            \ }
let g:choosewin_color_overlay_current = {
            \ 'gui': ['firebrick1', 'firebrick1' ],
            \ 'cterm': [ 124, 124 ]
            \ }

let g:choosewin_blink_on_land      = 0 " dont' blink at land
let g:choosewin_statusline_replace = 0 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline
"}}}

"{{{ vim-diff-enhanced
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
"}}}

"{{{ vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['"'] = {
            \ 'pattern': '"',
            \ 'ignore_groups': ['!Comment']
            \ }
"}}}

"{{{ vim-easymotion
" based on [Vim-EasyMotionでカーソル移動を爆速にして生産性をもっと向上させる - haya14busa](http://haya14busa.com/mastering-vim-easymotion/)
" =======================================
" Boost your productivity with EasyMotion
" =======================================
" Disable default mappings
" If you are true vimmer, you should explicitly map keys by yourself.
" Do not rely on default bidings.
let g:EasyMotion_do_mapping = 0

" Or map prefix key at least(Default: <Leader><Leader>)
" map <Leader> <Plug>(easymotion-prefix)

" =======================================
" Find Motions
" =======================================
" Jump to anywhere you want by just `4` or `3` key strokes without thinking!
" `s{char}{char}{target}`
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
" Of course, you can map to any key you want such as `<Space>`
" map <Space>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" =======================================
" Line Motions
" =======================================
" `JK` Motions: Extend line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" keep cursor column with `JK` motions
let g:EasyMotion_startofline = 0

" =======================================
" General Configuration
" =======================================
let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
" Show target key with upper case to improve readability
let g:EasyMotion_use_upper = 1
" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_use_migemo = 1


" =======================================
" Search Motions
" =======================================
" Extend search motions with vital-over command line interface
" Incremental highlight of all the matches
" Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
"}}}

"{{{ vim-hybrid
let g:hybrid_use_Xresources = 1
set background=dark
colorscheme hybrid
"}}}

"{{{ vim-jsx
let g:hybrid_use_Xresources = 1
set background=dark
colorscheme hybrid
"}}}

"{{{ vim-over
nnoremap <silent> <Leader>s :<C-u>OverCommandLine<CR>
"}}}

"{{{ vim-quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)
map ,h <Plug>(operator-quickhl-manual-this-motion)
"}}}

"{{{ vim-quickrun
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
            \ 'runner': 'vimproc',
            \ 'runner/vimproc/updatetime': 40,
            \ }
"}}}

"{{{ vim-watchdogs
let g:watchdogs_check_BufWritePost_enable = 1

if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
let g:quickrun_config["watchdogs_checker/_"] = {
            \ "outputter": "error",
            \ "outputter/error": "quickfix",
            \ "outputter/error/quickfix/open_cmd": "",
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

" for Python
let g:quickrun_config["python/watchdogs_checker"] = {
            \ "type"
            \     : executable("flake8") ? "watchdogs_checker/flake8"
            \     : executable("pyflakes") ? "watchdogs_checker/pyflakes"
            \     : ""
            \ }

" watchdogs.vim の設定を追加
call watchdogs#setup(g:quickrun_config)
" for lightline
let g:Qfstatusline#UpdateCmd = function('lightline#update')
"}}}

"{{{ yankround
let g:yankround_use_ctrlp = 1
let g:yankround_max_history = 50

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-k> <Plug>(yankround-prev)
nmap <C-j> <Plug>(yankround-next)
cmap <C-r> <Plug>(yankround-insert-register)
cmap <C-y> <Plug>(yankround-pop)
"}}}

"{{{ YouCompleteMe
" For 'scrooloose/syntastic'
let g:ycm_show_diagnostics_ui = 0

nnoremap <leader>dd :<C-u>YcmCompleter GoTo<CR>
nnoremap <leader>dr :<C-u>YcmCompleter GoToReferences<CR>
nnoremap <leader>gd :<C-u>YcmCompleter GetDoc<CR>
nnoremap <leader>I :<C-u>YcmCompleter GetType<CR>


let g:ycm_filetype_blacklist = {}

let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filepath_completion_use_working_dir = 1
"}}}

"}}}

"{{{ File Type Config

"{{{ html
function! s:setup_html()
    let g:quickrun_config['html'] = { 'command' : 'open', 'exec' : '%c %s', 'outputter': 'browser' }
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
let g:go_fmt_options = '-s'
" metalinterにオプションを付ける方法が用意されていなかったのでとりあえず無理やり混ぜ込む
let g:go_metalinter_deadline = '10s --tests'
let g:go_metalinter_enabled = [
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
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
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

let g:go_def_reuse_buffer = 1

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
    nnoremap <C-p>t :<C-u>GoDecls<CR>
    nnoremap <C-p>T :<C-u>GoDeclsDir<CR>
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
let g:markdown_enable_spell_checking = 0
let g:markdown_mapping_switch_status = '<Learder>x'

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
function! s:setup_scss()
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction
"}}}

"{{{ typescript
function! s:setup_typescript()
    nnoremap <buffer> <leader>dd :<C-u>YcmCompleter GoToDefinition<CR>
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
let g:WMGraphviz_output='png'
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
