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

""""""""""""""""""""
"  buffer key map  "
""""""""""""""""""""
nnoremap <silent> <space>bp :<C-u>bprevious<CR>
nnoremap <silent> <space>bn :<C-u>bnext<CR>

""""""""""""""""""""""
"  quickfix key map  "
""""""""""""""""""""""
nnoremap <silent> <space>cc :<C-u>cc<CR>
nnoremap <silent> <space>co :<C-u>copen<CR>
nnoremap <silent> <space>cO :<C-u>cclose<CR>
nnoremap <silent> <space>cn :<C-u>cnext<CR>
nnoremap <silent> <space>cN :<C-u>clast<CR>
nnoremap <silent> <space>cp :<C-u>cprevious<CR>
nnoremap <silent> <space>cP :<C-u>cfirst<CR>
nnoremap <silent> <space>cfn :<C-u>cnfile<CR>
nnoremap <silent> <space>cfp :<C-u>cpfile<CR>

nnoremap <silent> <space>ll :<C-u>ll<CR>
nnoremap <silent> <space>lo :<C-u>lopen<CR>
nnoremap <silent> <space>lO :<C-u>lclose<CR>
nnoremap <silent> <space>ln :<C-u>lnext<CR>
nnoremap <silent> <space>lN :<C-u>llast<CR>
nnoremap <silent> <space>lp :<C-u>lprevious<CR>
nnoremap <silent> <space>lP :<C-u>lfirst<CR>
nnoremap <silent> <space>lfn :<C-u>lnfile<CR>
nnoremap <silent> <space>lfp :<C-u>lpfile<CR>
