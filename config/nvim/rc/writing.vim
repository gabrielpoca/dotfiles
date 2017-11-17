let g:pencil#autoformat = 1
let g:pencil#wrapModeDefault = 'soft'

function! WriteMode()
  setlocal nonumber
  setlocal norelativenumber
  setlocal complete+=kspell
  setlocal foldcolumn=10
  highlight FoldColumn guibg=gb
  highlight SignColumn guibg=gb
  highlight FoldColumn guifg=#1d1f21
  SoftPencil
  Voom markdown
endfunction

com! WM call WriteMode()

augroup remember_md_folds
  autocmd!
  autocmd BufWinLeave,BufLeave,WinLeave *.md mkview
  autocmd BufWinEnter *.md silent loadview
augroup END

autocmd BufRead,BufNewFile ,*.md setlocal complete+=kspell spell
autocmd FileType gitcommit setlocal complete+=kspell spell
