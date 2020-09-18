list_of_terms = {}
job_ids = {}

floating = require "../floating"

function SideTerminal(nr, command, ...)
  if command == nil then
    command = "/usr/local/bin/fish"
  end

  wins = vim.api.nvim_list_wins()

  if wins[2] == nil then
    vim.cmd(":vsplit")
  end

  wins = vim.api.nvim_list_wins()
  vim.api.nvim_set_current_win(wins[#wins])

  if list_of_terms[nr] and vim.fn.jobwait({job_ids[nr]}, 0)[1] == -1 then
    vim.api.nvim_set_current_buf(list_of_terms[nr])
  else
    list_of_terms[nr] = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_set_current_buf(list_of_terms[nr])
    job_ids[nr] = vim.fn.termopen(command)
    vim.cmd 'set winhl=Normal:Floating'
  end

  vim.cmd(":startinsert")
end

function FloatingTerminal(nr, command, ...)
  if command == nil then
    command = "/usr/local/bin/fish"
  end

  if list_of_terms[nr] and vim.fn.jobwait({job_ids[nr]}, 0)[1] == -1 then
    floating.new_buffer(list_of_terms[nr])
  else
    list_of_terms[nr] = vim.api.nvim_create_buf(false, false)
    floating.new_buffer(list_of_terms[nr])
    job_ids[nr] = vim.fn.termopen(command)
    vim.cmd(":au WinLeave <buffer> :close")
  end

  vim.cmd(":startinsert")
end

vim.api.nvim_set_keymap('n', "<leader>su", ":lua SideTerminal(1)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>si", ":lua SideTerminal(2)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>so", ":lua SideTerminal(3)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>sp", ":lua SideTerminal(4)<cr>", { silent = true })

-- floating terminals
vim.api.nvim_set_keymap('n', "<leader>tu", ":lua FloatingTerminal(1)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>ti", ":lua FloatingTerminal(2)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>to", ":lua FloatingTerminal(3)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>tp", ":lua FloatingTerminal(4)<cr>", { silent = true })
