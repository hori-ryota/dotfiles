function localfunc#refresh#refresh_vimrc()
  call dein#recache_runtimepath()
  execute 'source' $MYVIMRC
endfunction
