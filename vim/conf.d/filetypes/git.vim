let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0
let g:fugitive_github_domains = ['[^/]*']

nnoremap <silent> <space>g :<C-u>Git<space>
nnoremap <silent> <Leader>ga :<C-u>Gwrite<CR>
nnoremap <silent> <Leader>gc :<C-u>Gcommit<CR>
nnoremap <silent> <Leader>gs :<C-u>Gstatus<CR>
nnoremap <silent> <Leader>gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> <Leader>gh :<C-u>GitGutterLineHighlightsToggle<CR>
