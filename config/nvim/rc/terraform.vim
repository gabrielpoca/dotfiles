function! TfDocForWordUnderCursor ()
  let word = substitute(expand("<cword>"), 'aws_', '', '')
  let url = "https://www.terraform.io/docs/providers/aws/r/".word.".html"
  silent exec "!open ".url
endfunction

function! TfPlan() abort
  let cd="cd ".expand('%:p:h')
  call neoterm#do({ 'cmd': cd })
  call neoterm#do({ 'cmd': 'terraform plan' })
endfunction

function! TfInit() abort
  let cd="cd ".expand('%:p:h')
  call neoterm#do({ 'cmd': cd })
  call neoterm#do({ 'cmd': 'terraform init' })
endfunction

autocmd FileType terraform nnoremap <silent> <leader>fp :call TfPlan()<cr>
autocmd FileType terraform nnoremap <silent> <leader>fi :call TfInit()<cr>
autocmd FileType terraform nnoremap <silent> <leader>dw :call TfDocForWordUnderCursor()<cr>
