set diffopt+=vertical
if &diff
map <leader>1 :diffget LOCAL<CR>
map <leader>2 :diffget BASE<CR>
map <leader>3 :diffget REMOTE<CR>
endif
