local api = vim.api

local M = {}

local statusExists = false

M.status = function()
  if statusExists then
    vim.cmd("FloatermToggle git")
  else
    vim.cmd("FloatermNew! --name=git tig")
    statusExists = true
  end

  vim.defer_fn(function() vim.cmd("startinsert") end, 100)
end

M.file_history = function()
  vim.cmd("FloatermNew! --disposable tig " .. api.nvim_call_function("expand", {"%:p"}))
end

set_keymaps({
    ['<Leader>gs'] = 'vertical G',
    ['<Leader>gh'] = 'lua require"git".file_history()', -- show current file's history in tig
    ['<Leader>gb'] = 'Gblame' -- show commits for every source line
  })

return M
