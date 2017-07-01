" linter
let g:neomake_prose_maker = {
  \ 'exe': 'proselint',
  \ 'args': ['%:p'],
  \ 'errorformat': '%f:%l:%c:%m',
  \ }

let g:pencil#autoformat = 0
let g:neomake_markdown_enabled_makers = ['proselint']

" => write mode
function! WriteMode()
  setlocal nonumber
  setlocal norelativenumber
  setlocal complete+=kspell
  setlocal foldcolumn=10
  highlight FoldColumn guibg=gb
  highlight SignColumn guibg=gb
  HardPencil
  Voom vimwiki
endfunction

com! WM call WriteMode()

augroup remember_folds
  autocmd!
  autocmd BufWinLeave,BufLeave,WinLeave *.wiki mkview
  autocmd BufWinEnter *.wiki silent loadview
augroup END

" => Spell
autocmd BufRead,BufNewFile *.wiki,*.md setlocal complete+=kspell spell
autocmd BufRead,BufNewFile *.wiki setlocal foldcolumn=0
autocmd FileType gitcommit setlocal complete+=kspell spell
