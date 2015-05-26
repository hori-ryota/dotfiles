" Default mappings
"" let g:ctrlp_map = '<c-p>'
"" let g:ctrlp_cmd = 'CtrlP'

if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
endif

let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command = 'find %s -type f | grep -v "DS_Store\|\.git/\|\.hg/\|\.svn/\|optimized/\|compiled/\|node_modules/\|bower_components/\|dest/\|target/\|public/\|Alfred.alfredpreferences/\|alfred/workflows/\|plugged/"'        " MacOSX/Linux
