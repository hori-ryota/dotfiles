""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Comment Config                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Commenting blocks of code."{{{
augroup CommentSettings
    autocmd!
    autocmd FileType c,cpp,java,scala,go  set commentstring=//\ %s
    autocmd FileType javascript           set commentstring=//\ %s
    autocmd FileType sh,ruby,python       set commentstring=#\ %s
    autocmd FileType conf,fstab           set commentstring=#\ %s
    autocmd FileType tex                  set commentstring=%\ %s
    autocmd FileType mail                 set commentstring=>\ %s
    autocmd FileType vim                  set commentstring=\"\ %s
    autocmd FileType sql                  set commentstring=--\ %s
augroup END
"}}}
