
" hide characters between panes
set fillchars+=vert:\ 

if has('termguicolors')
  set termguicolors
  " Don't need this in xterm-256color, but do need it inside tmux.
  " (See `:h xterm-true-color`.)
  if &term =~# 'tmux-256color'
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
  endif
endif

" theme and colors
set background=dark
lua require("colors").setup('nord')

" vim-highlightedyank duration of the highlight
let g:highlightedyank_highlight_duration = 300

" vim-highlightedyank color or the highlight
highlight HighlightedyankRegion cterm=reverse gui=reverse
