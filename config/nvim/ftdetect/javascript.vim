function! s:index(name, from) abort
ruby << EOF
  VIM.command(":echo '#{name + '/index.jsx'}'")
EOF
endfunction

au BufNewFile,BufRead * setlocal includeexpr="s:index(v:fname, bufname('%'))"
