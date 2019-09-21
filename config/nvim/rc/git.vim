" in interactive rebase, change all commits to squash except for the first
nmap <Leader>gs mzggjvG$:s/^pick/s<CR>

" get the pull request's description
nmap <leader>gd :r !git pr-description<CR>

" show current file's history in tig, on a new tmux window
nmap <silent> <leader>gh :silent execute "!tmux new-window tig " . expand("%:p")<CR>

" show commits for every source line
nnoremap <Leader>gb :Gblame<CR> 


" show octobox notifications
nnoremap <Leader>gn :CocList octobox<CR>
