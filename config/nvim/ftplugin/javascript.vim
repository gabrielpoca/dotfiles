function! s:index(name, from) abort
ruby << EOF
  VIM.command(":echo '#{name + '/index.jsx'}'")
EOF
endfunction

au BufNewFile,BufRead * setlocal includeexpr="s:index(v:fname, bufname('%'))"

" extensions permitted with gf
autocmd FileType javascript set suffixesadd=.js,.json,.html,.jsx,.tsx,.ts

" indent jsx with peitalin/vim-jsx-typescript
"autocmd BufNewFile,BufRead *.jsx set filetype=typescript.tsx

" pangloss/vim-javascript
let g:javascript_conceal_arrow_function = "⇒"

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'react,ramda,underscore,jquery,angularjs'
