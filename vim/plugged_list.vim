call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""
"  crtlp  "
"""""""""""
Plug 'ctrlpvim/ctrlp.vim'

""""""""""""""""
"  Status bar  "
""""""""""""""""
" color scheme for lightline
Plug 'cocopon/lightline-hybrid.vim'
Plug 'itchyny/lightline.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Color Scheme                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0ng/vim-hybrid'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Programming                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""
"  YouCompleteMe  "
"""""""""""""""""""
Plug 'Valloric/YouCompleteMe', {
            \ 'do': 'brew install cmake && ./install.sh --clang-completer'
            \ }

"""""""""""""
"  Snippet  "
"""""""""""""
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"""""""""""
"  Filer  "
"""""""""""
Plug 'scrooloose/nerdtree', {
            \ 'on': 'NERDTreeToggle'
            \ }

""""""""""""
"  Visual  "
""""""""""""
Plug 't9md/vim-choosewin', {
            \ 'on': '<Plug>(choosewin)'
            \ }

""""""""""""
"  Editor  "
""""""""""""
" edit surround easy
Plug 'tpope/vim-surround'
" Aligning Text
Plug 'junegunn/vim-easy-align'
" comment stuff out
Plug 'tpope/vim-commentary'
" reuse register
Plug 'LeafCage/yankround.vim'

""""""""""""
"  Motion  "
""""""""""""
Plug 'Lokaltog/vim-easymotion'
" highlight substitute target
Plug 'osyo-manga/vim-over'

Plug 'rhysd/clever-f.vim'

"""""""""""""""""
"  Programming  "
"""""""""""""""""
" syntax check
Plug 'scrooloose/syntastic'

""""""""""""""
"  Git/Gist  "
""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'

""""""""""""""""
"  Javascript  "
""""""""""""""""
Plug 'pangloss/vim-javascript', {
            \ 'for': 'javascript'
            \ }
Plug 'marijnh/tern_for_vim', {
            \ 'do': 'npm install',
            \ 'for': 'javascript'
            \ }
Plug 'jiangmiao/simple-javascript-indenter', {
            \ 'for': 'javascript'
            \ }
Plug 'briancollins/vim-jst', {
            \ 'for': ['jst', 'ejs']
            \ }
Plug 'groenewege/vim-less', {
            \ 'for': 'less'
            \ }
Plug 'digitaltoad/vim-jade', {
            \ 'for': 'jade'
            \ }
Plug 'cakebaker/scss-syntax.vim', {
            \ 'for': 'scss'
            \ }
Plug 'kchmck/vim-coffee-script', {
            \ 'for': 'coffee'
            \ }

""""""""""
"  Ruby  "
""""""""""
Plug 'vim-ruby/vim-ruby', {
            \ 'for': ['ruby', 'eruby', 'haml']
            \ }
Plug 'ruby-matchit', {
            \ 'for': ['ruby', 'eruby', 'haml']
            \ }
Plug 'skwp/vim-rspec', {
            \ 'for': 'ruby'
            \ }
Plug 'Keithbsmiley/rspec.vim', {
            \ 'for': 'ruby'
            \ }
Plug 'tpope/vim-rails', {
            \ 'for': 'ruby'
            \ }

""""""""""
"  html  "
""""""""""
" emmet
Plug 'mattn/emmet-vim', {
            \ 'for': ['html', 'ejs', 'erb']
            \ }

""""""""""""""
"  Markdown  "
""""""""""""""
" Depended by vim-markdown
Plug 'godlygeek/tabular', {
            \ 'for': 'markdown'
            \ }

Plug 'rcmdnk/vim-markdown', {
            \ 'for': 'markdown'
            \ }
" Depended by previm
Plug 'tyru/open-browser.vim', {
            \ 'for': 'markdown'
            \ }
" Preview
Plug 'kannokanno/previm', {
            \ 'for': 'markdown'
            \ }

""""""""""
"  JSON  "
""""""""""
" Preview
Plug 'elzr/vim-json', {
            \ 'for': 'javascript'
            \ }

""""""""""
"  Misc  "
""""""""""
" quickrun
Plug 'thinca/vim-quickrun'
" list tags
Plug 'majutsushi/tagbar', {
            \ 'do': 'brew install ctags',
            \ 'on': 'TagbarToggle'
            \ }
" mark and highlight words
Plug 't9md/vim-quickhl', {
            \ 'on': '<Plug>(quickhl-'
            \ }
" Depended by memolist
Plug 'fuenor/qfixgrep'
" memo
Plug 'glidenote/memolist.vim'
" concentration mode
Plug 'junegunn/goyo.vim', {
            \ 'on': 'Goyo'
            \ }

call plug#end()
