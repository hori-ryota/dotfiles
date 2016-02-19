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

"""""""""""""
"  history  "
"""""""""""""
Plug 'sjl/gundo.vim'

""""""""""""""
"   content  "
""""""""""""""

Plug 'vim-scripts/diffchar.vim'

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
            \ 'do': 'brew install cmake; ./install.sh --clang-completer --gocode-completer'
            \ }

"""""""""""""
"  Snippet  "
"""""""""""""
Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'

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
Plug 'Yggdroot/indentLine'

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
" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

""""""""""""
"  Motion  "
""""""""""""
Plug 'Lokaltog/vim-easymotion'
" highlight substitute target
Plug 'osyo-manga/vim-over'
" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

"""""""""""""""""
"  Programming  "
"""""""""""""""""
" syntax check
Plug 'osyo-manga/vim-watchdogs'
Plug 'osyo-manga/shabadou.vim'
Plug 'Shougo/vimproc.vim', {
      \ 'do': 'make -f make_mac.mak'
      \ }
Plug 'KazuakiM/vim-qfstatusline'
Plug 'cohama/vim-hier'
Plug 'dannyob/quickfixstatus'

""""""""""""""
"  Git/Gist  "
""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'idanarye/vim-merginal'
" Gist
Plug 'lambdalisue/vim-gista', {
            \ 'on': ['Gista', '<Plug>(gista-']
            \ }

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
Plug 'mxw/vim-jsx', {
            \ 'for': 'javascript'
            \ }

""""""""
"  go  "
""""""""
Plug 'fatih/vim-go', {
            \ 'for': 'go'
            \ }

""""""""""""""""""""""
"  Protocol Buffers  "
""""""""""""""""""""""
Plug 'uarun/vim-protobuf', {
            \ 'for': 'proto'
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

""""""""""""
"  Stylus  "
""""""""""""
Plug 'wavded/vim-stylus', {
            \ 'for': 'stylus'
            \}

""""""""""""""
"  Markdown  "
""""""""""""""
Plug 'godlygeek/tabular', {
            \ 'for': 'markdown'
            \ }
            \ |
            \ Plug 'gabrielelana/vim-markdown', {
            \ 'for': 'markdown'
            \ }

" Preview
Plug 'tyru/open-browser.vim', {
            \ 'for': 'markdown'
            \ }
            \ |
            \ Plug 'kannokanno/previm', {
            \ 'for': 'markdown'
            \ }

""""""""""
"  JSON  "
""""""""""
" Preview
Plug 'elzr/vim-json', {
            \ 'for': 'javascript'
            \ }

""""""""""""""""
"  Dockerfile  "
""""""""""""""""
Plug 'ekalinin/Dockerfile.vim', {
            \ 'for': 'dockerfile'
            \ }

"""""""""""""
"  Ansible  "
"""""""""""""
Plug 'chase/vim-ansible-yaml', {
            \ 'for': 'ansible'
            \ }

"""""""""""""""
"  Terraform  "
"""""""""""""""
Plug 'hashivim/vim-terraform', {
            \ 'for': ['terraform', 'javascript']
            \ }

""""""""""""""
"  PlantUML  "
""""""""""""""
Plug 'aklt/plantuml-syntax', {
            \ 'for': ['pu', 'uml', 'plantuml']
            \ }

"""""""""""""""
"   Graphviz  "
"""""""""""""""
Plug 'wannesm/wmgraphviz.vim', {
            \ 'for': 'dot'
            \ }

"""""""""
"  SQL  "
"""""""""
Plug 'vim-scripts/SQLUtilities', {
            \ 'for': 'sql'
            \ }
Plug 'vim-scripts/Align', {
            \ 'for': 'sql'
            \ }

""""""""""
"  Misc  "
""""""""""
" the_silver_searcher
Plug 'rking/ag.vim'
" quickrun
Plug 'thinca/vim-quickrun'
" list tags
Plug 'majutsushi/tagbar', {
            \ 'do': 'brew install ctags',
            \ }
" mark and highlight words
Plug 't9md/vim-quickhl', {
            \ 'on': '<Plug>(quickhl-'
            \ }
" memo
Plug 'fuenor/qfixgrep' | Plug 'glidenote/memolist.vim'
" use histogram algorithm for vimdiff
Plug 'chrisbra/vim-diff-enhanced'

call plug#end()
