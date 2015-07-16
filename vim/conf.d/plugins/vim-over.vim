nnoremap <silent> <Leader>m :<C-u>OverCommandLine<CR>
" カーソル下の単語をハイライト付きで置換
nnoremap sub :<C-u>OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
nnoremap subp y:<C-u>OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>
