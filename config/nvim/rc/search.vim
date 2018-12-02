let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(blue)%C(bold)%cr%C(white)"'

" shortcuts
nmap <leader>o :Buffers<cr>
nmap <leader>p :Files<cr>
nmap <leader>i :GFiles<cr>

" search
nnoremap <silent> <leader><cr> :nohlsearch<CR><C-L>

" search word under cursor
nnoremap <silent> <Leader>fw :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>ff :Ag 

" hide status line inside fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
