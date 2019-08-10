set fillchars+=vert:\ 
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'
colorscheme gruvbox

highlight ActiveWindow guibg=#1d2021
highlight InactiveWindow guibg=#282828

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter,FocusGained * call Handle_Win_Enter()
  autocmd WinLeave,FocusLost * call Handle_Win_Leave()
augroup END

" hide status line inside fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,SignColumn:ActiveWindow
endfunction

function! Handle_Win_Leave()
  setlocal winhighlight=Normal:InactiveWindow,SignColumn:InactiveWindow
endfunction

"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
  "\ 'bg':      ['bg', 'Normal'],
  "\ 'hl':      ['fg', 'Comment'],
  "\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  "\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  "\ 'hl+':     ['fg', 'Statement'],
  "\ 'info':    ['fg', 'PreProc'],
  "\ 'border':  ['fg', 'Ignore'],
  "\ 'prompt':  ['fg', 'Conditional'],
  "\ 'pointer': ['fg', 'Exception'],
  "\ 'marker':  ['fg', 'Keyword'],
  "\ 'spinner': ['fg', 'Label'],
  "\ 'header':  ['fg', 'Comment'] }

"highlight Normal guibg=none
"highlight SignColumn guibg=none

"augroup NrHighlight
  "autocmd!
  "autocmd WinEnter * highlight Normal guibg=#1d2021
  "autocmd WinEnter * highlight SignColumn guibg=#1d2021
  "autocmd WinLeave * highlight Normal guibg=none
  "autocmd WinLeave * highlight SignColumn guibg=none
"augroup END
