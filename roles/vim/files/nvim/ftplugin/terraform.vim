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

  execute ":T (cd " . l:dir . " && direnv exec . terraform " . a:cmd . ")"
endfunction

nmap <silent> <leader>fi :call TerraformCmd(@%, "init")<CR>
nmap <silent> <leader>fp :call TerraformCmd(@%, "plan")<CR>
nmap <silent> <leader>fa :call TerraformCmd(@%, "apply")<CR>
nmap <silent> <leader>fo :call TerraformCmd(@%, "output")<CR>
nmap <silent> <leader>fr :call TerraformCmd(@%, "refresh")<CR>
nmap <silent> <leader>fd :call TerraformCmd(@%, "destroy")<CR>
nmap <silent> <leader>fy :T yes<CR>
nmap <silent> <leader>fn :T no<CR>

nmap <silent> <leader>dw :call TfDocForWordUnderCursor()<cr>
