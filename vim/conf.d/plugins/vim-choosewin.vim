" invoke with '-'
nmap  -  <Plug>(choosewin)

" use overlay feature
let g:choosewin_overlay_enable = 1

" workaround for overlay font broken on mutibyte buffer.
let g:choosewin_overlay_clear_multibyte = 1

" tmux like overlay color
let g:choosewin_color_overlay = {
            \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
            \ 'cterm': [ 25, 25 ]
            \ }
let g:choosewin_color_overlay_current = {
            \ 'gui': ['firebrick1', 'firebrick1' ],
            \ 'cterm': [ 124, 124 ]
            \ }

let g:choosewin_blink_on_land      = 0 " dont' blink at land
let g:choosewin_statusline_replace = 0 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline
