list_of_terms = {}

floating = require "../floating"


function SideTerminal(nr, command, ...)
  if command == nil then
    command = "/usr/local/bin/fish"
  end

  wins = vim.api.nvim_list_wins()

  if wins[2] == nil then
    vim.api.nvim_command(":vsplit")
  end

  wins = vim.api.nvim_list_wins()
  vim.api.nvim_set_current_win(wins[#wins])

  if list_of_terms[nr] then
    vim.api.nvim_set_current_buf(list_of_terms[nr])
  else
    list_of_terms[nr] = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_set_current_buf(list_of_terms[nr])
    vim.api.nvim_call_function("termopen", {command})
    vim.cmd 'set winhl=Normal:Floating'
  end

  vim.api.nvim_command(":startinsert")
end

function FloatingTerminal(nr, command, ...)
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

vim.api.nvim_set_keymap('n', "<leader>su", ":lua SideTerminal(1)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>si", ":lua SideTerminal(2)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>so", ":lua SideTerminal(3)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>sp", ":lua SideTerminal(4)<cr>", { silent = true })

-- floating terminals
vim.api.nvim_set_keymap('n', "<leader>tu", ":lua FloatingTerminal(1)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>ti", ":lua FloatingTerminal(2)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>to", ":lua FloatingTerminal(3)<cr>", { silent = true })
vim.api.nvim_set_keymap('n', "<leader>tp", ":lua FloatingTerminal(4)<cr>", { silent = true })
