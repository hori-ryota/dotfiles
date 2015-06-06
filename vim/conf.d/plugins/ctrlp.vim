" Default mappings
"" let g:ctrlp_map = '<C-p>'
"" let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_map = '<C-p><C-p>'

let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command = 'find %s -type f | grep -v "DS_Store\|\.git/\|\.hg/\|\.svn/\|optimized/\|compiled/\|node_modules/\|bower_components/\|dest/\|target/\|public/\|Alfred.alfredpreferences/\|alfred/workflows/\|plugged/"'        " MacOSX/Linux

nnoremap <C-p>p <C-u>:CtrlP<CR>
nnoremap <C-p>b <C-u>:CtrlPBuffer<CR>
nnoremap <C-p>m <C-u>:CtrlPMRU<CR>
nnoremap <C-p>t <C-u>:CtrlPTag<CR>
nnoremap <C-p>bt <C-u>:CtrlPBufTag<CR>
nnoremap <C-p>q <C-u>:CtrlPQuickfix<CR>
nnoremap <C-p>d <C-u>:CtrlPDir<CR>
nnoremap <C-p>r <C-u>:CtrlPPTS<CR>
nnoremap <C-p>u <C-u>:CtrlPUndo<CR>
nnoremap <C-p>l <C-u>:CtrlPLine<CR>
nnoremap <C-p>c <C-u>:CtrlPChange<CR>
nnoremap <C-p>x <C-u>:CtrlPMixed<CR>
nnoremap <C-p>y <C-u>:CtrlPYankRound<CR>
