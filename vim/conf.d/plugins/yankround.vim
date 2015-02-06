let g:yankround_use_ctrlp = 1
let g:yankround_max_history = 50

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>ext)
