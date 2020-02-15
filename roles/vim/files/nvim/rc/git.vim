" in interactive rebase, change all commits to squash except for the first
nmap <Leader>gs mzggjvG$:s/^pick/s<CR>

" get the pull request's description
nmap <Leader>gd :r !git pr-description<CR>

" show current file's history in tig, on a new tmux window
nnoremap <Leader>gh :lua TerminalTigCurrentFile()<CR>

"nnoremap <Leader>gg :TigOpenProjectRootDir<CR>
nmap <silent> <Leader>gg :lua TerminalTig()<CR>

" show commits for every source line
nnoremap <Leader>gb :TigGblame<CR> 

" show octobox notifications
nnoremap <Leader>gn :CocList octobox<CR>
