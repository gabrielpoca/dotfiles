list_of_terms = {}

floating = require "../floating"

function Terminal(nr, command, ...)
  if command == nil then
    command = "/usr/local/bin/fish"
  end

  if list_of_terms[nr] then
    floating.new_buffer(list_of_terms[nr])
  else
    list_of_terms[nr] = vim.api.nvim_create_buf(false, false)
    floating.new_buffer(list_of_terms[nr])
    vim.api.nvim_call_function("termopen", {command})
    vim.api.nvim_command(":au WinLeave <buffer> :close")
  end

  vim.api.nvim_command(":startinsert")
end

tig_current_nr = 100

function TerminalTig()
  TerminalTigOpen("tig status")
end

function TerminalTigCurrentFile()
  TerminalTigOpen("tig " .. vim.api.nvim_call_function("expand", {"%:p"}))
end

function TerminalTigOpen(command)
  Terminal(tig_current_nr, command)
  tig_current_nr = tig_current_nr + 1
end

-- miscellaneous terminals
vim.api.nvim_set_keymap('n', "<leader>tu", ":lua Terminal(1)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>ti", ":lua Terminal(2)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>to", ":lua Terminal(3)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>tp", ":lua Terminal(4)<cr>", { silent = true })

-- run tests for whole test suite
vim.api.nvim_set_keymap('n', "<leader>ra", ":TestSuite<cr>", { silent = true, noremap = true })

-- show current file's history in tig, on a new tmux window
vim.api.nvim_set_keymap('n', "<Leader>gh", ":lua TerminalTigCurrentFile()<CR>", { silent = true })

-- open tig in project folder
vim.api.nvim_set_keymap('n', "<Leader>gg", ":lua TerminalTig()<CR>", { silent = true })

-- show commits for every source line
vim.api.nvim_set_keymap('n', "<Leader>gb", ":Gblame<CR>", { silent = true })

-- push
vim.api.nvim_set_keymap('n', "<Leader>gp", ":!git push<CR>", { silent = true })

-- force push
vim.api.nvim_set_keymap('n', "<Leader>gP", ":!git push -f<CR>", { silent = true })

vim.api.nvim_set_keymap('n', "<Leader>go", ":!hub browse<CR>", { silent = true })
