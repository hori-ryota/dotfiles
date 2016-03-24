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
