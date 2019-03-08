function! DockerfileDocForWordUnderCursor ()
  let word = tolower(expand("<cword>"))
  let url = "https://docs.docker.com/engine/reference/builder/\\#".word
  silent exec "! open ".url
endfunction

autocmd FileType dockerfile nnoremap <silent> <leader>dw :call DockerfileDocForWordUnderCursor()<cr>
