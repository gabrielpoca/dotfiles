lua require("git")

" in interactive rebase, change all commits to squash except for the first
autocmd FileType gitrebase nmap <Leader>gs mzggjvG$:s/^pick/s<CR>

" show commit contains current position
nmap <leader>gv <Plug>(coc-git-commit)

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
