local Floating = require'floating'
local Terminal = require'terminal'

local api = vim.api

local M = {}

M.file_history = function()
  M.new_tig_window("tig " .. api.nvim_call_function("expand", {"%:p"}))
end

set_keymaps({
    ['<Leader>gh'] = 'lua require"git".file_history()', -- show current file's history in tig
    ['<Leader>gb'] = 'Gblame' -- show commits for every source line
  })

return M
