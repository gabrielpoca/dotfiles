local Floating = require'floating'
local Terminal = require'terminal'

local api = vim.api

local M = {}

M.on_demand_terminal = 101
M.lazygit_terminal = 1000;

M.new_tig_window = function(command)
  Terminal.floating(M.on_demand_terminal, command)
  M.on_demand_terminal = M.on_demand_terminal + 1
end

M.status = function()
  Terminal.floating(M.lazygit_terminal, 'lazygit', {
      on_exit = function()
        Terminal.close()
        M.lazygit_terminal = M.lazygit_terminal + 1
      end
    })

  vim.cmd("autocmd BufWinEnter,WinEnter <buffer> silent! normal i")
end

M.file_history = function()
  M.new_tig_window("tig " .. api.nvim_call_function("expand", {"%:p"}))
end

M.edit = function(file)
  Terminal.close()

  vim.cmd("e " .. file)
end

set_keymaps({
    ['<Leader>gs'] = 'lua require"git".status()', -- open status in project folder
    ['<Leader>gi'] = 'lua require"ci_status".run()', -- show the current branch's CI status
    ['<Leader>gh'] = 'lua require"git".file_history()', -- show current file's history in tig
    ['<Leader>gb'] = 'Gblame', -- show commits for every source line
    ['<Leader>gc'] = 'GBranches --locals' -- show commits for every source line
  })

return M
