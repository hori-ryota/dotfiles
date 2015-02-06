"""""""""""""""""""""""""""""""""""""
"  Change current directory easily  "
"""""""""""""""""""""""""""""""""""""
"{{{
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

"""""""""""""""""
"  tab key map  "
"""""""""""""""""
nnoremap <silent> <C-t>l :tabnext<CR>
nnoremap <silent> <C-t>h :tabprev<CR>
nnoremap <silent> <C-t>c :tabclose<CR>
nnoremap <silent> <C-t>n :tabnew<CR>
for n in range(1,9)
  execute 'nnoremap <silent> <C-t>'.n ':tabnext '.n.'<CR>'
endfor

""""""""""""""""""""
"  buffer key map  "
""""""""""""""""""""
nnoremap <silent> <Leader>bb :bprevious<CR>
nnoremap <silent> <Leader>bf :bnext<CR>
