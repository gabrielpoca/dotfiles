lua require("git")

" in interactive rebase, change all commits to squash except for the first
autocmd FileType gitcommit,gitrebase nmap <Leader>gs mzggjvG$:s/^pick/s<CR>

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

command GitCiStatus :lua require'ci_status'.run()
command GitFileHistory :lua require'git'.file_history()
