" CSS
autocmd FileType css set iskeyword+=-

" DOCKER
function! DockerfileDocForWordUnderCursor ()
  let word = tolower(expand("<cword>"))
  let url = "https://docs.docker.com/engine/reference/builder/\\#".word
  silent exec "! open ".url
endfunction

autocmd FileType Dockerfile nnoremap <silent> <leader>dw :call DockerfileDocForWordUnderCursor()<cr>

" TERRAFORM
function! TfDocForWordUnderCursor ()
  let word = substitute(expand("<cword>"), 'aws_', '', '')
  let url = "https://www.terraform.io/docs/providers/aws/r/".word.".html"
  silent exec "!open ".url
endfunction

function! TerraformCmd(filename, cmd)
  if(isdirectory(a:filename))
    let dir = strpart(a:filename, 0, strlen(a:filename) - 1)
  else
    let dir = a:filename
  endif
  let last_slash = strridx(dir, "/")
  let dir = strpart(dir, 0, last_slash)

  execute ":T (cd " . l:dir . " && direnv exec . terraform -parallelism=50 " . a:cmd . ")"
endfunction

autocmd FileType terraform nmap <silent> <leader>fi :call TerraformCmd(@%, "init")<CR>
autocmd FileType terraform nmap <silent> <leader>fp :call TerraformCmd(@%, "plan")<CR>
autocmd FileType terraform nmap <silent> <leader>fa :call TerraformCmd(@%, "apply")<CR>
autocmd FileType terraform nmap <silent> <leader>fo :call TerraformCmd(@%, "output")<CR>
autocmd FileType terraform nmap <silent> <leader>fr :call TerraformCmd(@%, "refresh")<CR>
autocmd FileType terraform nmap <silent> <leader>fd :call TerraformCmd(@%, "destroy")<CR>
autocmd FileType terraform nmap <silent> <leader>fy :T yes<CR>
autocmd FileType terraform nmap <silent> <leader>fn :T no<CR>
autocmd FileType terraform nmap <silent> <leader>dw :call TfDocForWordUnderCursor()<cr>

" TYPESCRIPT

" leafgarland/typescript-vim
let g:typescript_indent_disable = 1

" JAVASCRIPT

function! s:index(name, from) abort
ruby << EOF
  VIM.command(":echo '#{name + '/index.jsx'}'")
EOF
endfunction

au BufNewFile,BufRead * setlocal includeexpr="s:index(v:fname, bufname('%'))"

" extensions permitted with gf
autocmd FileType javascript set suffixesadd=.js,.json,.html,.jsx,.tsx,.ts

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'react,ramda,underscore,jquery,chai'

" VUE
" https://github.com/posva/vim-vue
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
