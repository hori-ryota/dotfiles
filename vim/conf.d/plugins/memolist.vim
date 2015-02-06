let g:memolist_path = "~/Dropbox/memo"
" suffix type (default markdown)
let g:memolist_memo_suffix = "txt"

" date format (default %Y-%m-%d %H:%M)
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
"" let g:memolist_memo_date = "epoch"
"" let g:memolist_memo_date = "%D %T"

" tags prompt (default 0)
let g:memolist_prompt_tags = 1

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
let g:memolist_filename_prefix_none = 1

" use various Ex commands (default '')
let g:memolist_ex_cmd = 'CtrlP'
let g:memolist_ex_cmd = 'NERDTree'

nnoremap <Leader>mn :MemoNew<CR>
nnoremap <Leader>ml :MemoList<CR>
nnoremap <Leader>mg :MemoGrep<CR>
" use CtrlP
nnoremap <Leader>mf :exe "CtrlP" g:memolist_path<cr><f5>
