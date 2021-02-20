" hide characters between panes
"set fillchars+=vert:\ 

if has('termguicolors')
  set termguicolors
  " Don't need this in xterm-256color, but do need it inside tmux.
  " (See `:h xterm-true-color`.)
  if &term =~# 'tmux-256color'
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
  endif
endif

set background=dark

lua require("colors").setup('gruvbox')

" highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

autocmd ColorScheme *
  \ hi CocExplorerNormalFloatBorder guifg=#414347 guibg=Normal
  \ | hi CocExplorerNormalFloat guibg=Normal
