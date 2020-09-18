tig_current_nr = 101

function FloatingTerminalTig()
  FloatingTerminal(100, "tig status")
  -- send refresh command to tig
  vim.api.nvim_input("R")
end

function FloatingTerminalTigCurrentFile()
  FloatingTerminalTigOpen("tig " .. vim.api.nvim_call_function("expand", {"%:p"}))
end

function FloatingTerminalTigOpen(command)
  FloatingTerminal(tig_current_nr, command)
  tig_current_nr = tig_current_nr + 1
end

-- show current file's history in tig, on a new tmux window
vim.api.nvim_set_keymap('n', "<Leader>gh", ":lua FloatingTerminalTigCurrentFile()<CR>", { silent = true })

-- open tig in project folder
vim.api.nvim_set_keymap('n', "<Leader>gg", ":lua FloatingTerminalTig()<CR>", { silent = true })

-- show commits for every source line
vim.api.nvim_set_keymap('n', "<Leader>gb", ":Gblame<CR>", { silent = true })

-- push
vim.api.nvim_set_keymap('n', "<Leader>gp", ":!git push<CR>", { silent = true })

-- force push
vim.api.nvim_set_keymap('n', "<Leader>gP", ":!git push -f<CR>", { silent = true })

-- open in browser
vim.api.nvim_set_keymap('n', "<Leader>go", ":!hub browse<CR>", { silent = true })
