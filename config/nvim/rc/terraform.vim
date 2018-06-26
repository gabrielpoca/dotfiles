function! TerraformDocForWordUnderCursor ()
  let word = substitute(expand("<cword>"), 'aws_', '', '')
  let url = "https://www.terraform.io/docs/providers/aws/r/".word.".html"
  silent exec "!open ".url
endfunction

autocmd FileType terraform nnoremap <silent> <leader>dw :call TerraformDocForWordUnderCursor()<cr>
