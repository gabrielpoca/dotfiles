lua require("git")

" changing the shell to bash makes fugitive much faster
"set shell=/bin/bash

" in interactive rebase, change all commits to squash except for the first
autocmd FileType gitrebase nmap <Leader>gs mzggjvG$:s/^pick/s<CR>

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" show commit contains current position
nmap <leader>gv <Plug>(coc-git-commit)
