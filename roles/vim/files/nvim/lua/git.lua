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

set_keymaps({
    ['<Leader>g'] = 'lua require"git".status()', -- open tig in project folder
    ['<Leader>Gh'] = 'lua require"git".file_history()', -- show current file's history in tig
    ['<Leader>Gb'] = 'Gblame' -- show commits for every source line
  })

return M
