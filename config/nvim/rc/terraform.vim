function! TfDocForWordUnderCursor ()
  let word = substitute(expand("<cword>"), 'aws_', '', '')
  let url = "https://www.terraform.io/docs/providers/aws/r/".word.".html"
  silent exec "!open ".url
endfunction

function TfCmd(filename, cmd)
  if(isdirectory(a:filename))
    let dir = strpart(a:filename, 0, strlen(a:filename) - 1)
  else
    let dir = a:filename
  endif
  let last_slash = strridx(dir, "/")
  let dir = strpart(dir, 0, last_slash)

  execute ":T (cd " . l:dir . " && terraform " . a:cmd . ")"
endfunction

autocmd FileType terraform nmap <silent> <leader>fi :call TfCmd(@%, "init")<CR>
autocmd FileType terraform nmap <silent> <leader>fp :call TfCmd(@%, "plan")<CR>
autocmd FileType terraform nmap <silent> <leader>fa :call TfCmd(@%, "apply")<CR>
autocmd FileType terraform nmap <silent> <leader>dw :call TfDocForWordUnderCursor()<cr>
