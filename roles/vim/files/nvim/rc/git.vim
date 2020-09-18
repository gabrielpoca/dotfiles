lua require("git")

" in interactive rebase, change all commits to squash except for the first
nmap <Leader>gs mzggjvG$:s/^pick/s<CR>

" get the pull request's description
nmap <Leader>gd :r !git pr-description<CR>

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
