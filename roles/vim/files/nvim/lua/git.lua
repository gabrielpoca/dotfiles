local Floating = require'floating'

local api = vim.api

local M = {}

M.on_demand_terminal = 101

M.new_tig_window = function(command)
  require'terminal'.floating(M.on_demand_terminal, command)
  M.on_demand_terminal = M.on_demand_terminal + 1
end

M.status = function()
  require'terminal'.tab(100, 'tig status')

  vim.cmd("autocmd BufWinEnter,WinEnter <buffer> silent! normal i")

  vim.defer_fn(function ()
    vim.api.nvim_input("R")
  end, 300)
end

M.file_history = function()
  M.new_tig_window("tig " .. api.nvim_call_function("expand", {"%:p"}))
end

M.status = function()
  local wins = api.nvim_list_wins()

  wins = filter_array(wins, function(win)
    buf = api.nvim_win_get_buf(win)

    return string.match(api.nvim_buf_get_name(buf), "NERD_tree") == nil
  end)

  if wins[2] == nil then
    vim.cmd("vsplit")
  end

  wins = api.nvim_list_wins()
  api.nvim_set_current_win(wins[#wins])

  api.nvim_call_function("FugitiveDetect", {vim.fn.getcwd()})
  vim.cmd("0Git")
end

set_keymaps({
    ['<Leader>gs'] = 'lua require"git".status()', -- open status in project folder
    ['<Leader>gi'] = 'lua require"ci_status".run()', -- show the current branch's CI status
    ['<Leader>gh'] = 'lua require"git".file_history()', -- show current file's history in tig
    ['<Leader>gb'] = 'Gblame', -- show commits for every source line
    ['<Leader>gc'] = 'GBranches --locals' -- show commits for every source line
  })

return M
