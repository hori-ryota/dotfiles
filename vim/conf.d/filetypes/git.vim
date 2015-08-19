let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0
let g:fugitive_github_domains = ['[^/]*']

setlocal foldlevel=99

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

nnoremap <silent> <space>gm :<C-u>MerginalToggle<CR>

cabbrev git Git
