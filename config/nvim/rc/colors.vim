" hide characters between panes
set fillchars+=vert:\ 

" theme and colors
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'
colorscheme gruvbox

" change the background in order to highlight the active pane
highlight ActiveWindow guibg=#1d2021
highlight InactiveWindow guibg=#282828

augroup WindowManagement
  autocmd!
  autocmd WinEnter,FocusGained,BufEnter * call Handle_Win_Enter()
  autocmd WinLeave,FocusLost,BufLeave * call Handle_Win_Leave()
augroup END

function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,SignColumn:ActiveWindow
endfunction

function! Handle_Win_Leave()
  setlocal winhighlight=Normal:InactiveWindow,SignColumn:InactiveWindow
endfunction

" hide status line inside fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
