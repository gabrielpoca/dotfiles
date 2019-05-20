" open alternate file defined in vim-projectionist
nmap <leader>fa :A<cr>
nmap <leader>fv :AV<cr>
" search for open buffers
nmap <leader>o :Buffers<cr>
" search for files
nmap <leader>p :Files<cr>
" search for lines in open buffers
nmap <leader>i :Lines<cr>

" clear search
nnoremap <silent> <leader><cr> :nohlsearch<CR><C-L>

" search word under cursor
nnoremap <silent> <Leader>fw :Ag <C-R><C-W><CR>
" search for something
nnoremap <silent> <Leader>ff :Ag 

" hide status line inside fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
