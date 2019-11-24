function! s:index(name, from) abort
ruby << EOF
  VIM.command(":echo '#{name + '/index.jsx'}'")
EOF
endfunction

au BufNewFile,BufRead * setlocal includeexpr="s:index(v:fname, bufname('%'))"

" extensions permitted with gf
autocmd FileType javascript set suffixesadd=.js,.json,.html,.jsx,.tsx,.ts

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'react,ramda,underscore,jquery,angularjs'
