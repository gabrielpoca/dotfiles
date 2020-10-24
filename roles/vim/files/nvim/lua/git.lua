local Floating = require'floating'
local api = vim.api

tig_current_nr = 101

local function tig_command(command)
  require'terminal'.floating(tig_current_nr, command)
  tig_current_nr = tig_current_nr + 1
end

local function tig_status()
  require'terminal'.tab(100, 'tig status')

  vim.cmd("autocmd BufWinEnter,WinEnter <buffer> silent! normal i")

  vim.defer_fn(function ()
    vim.api.nvim_input("R")
  end, 300)
end

local function current_file()
  tig_command("tig " .. api.nvim_call_function("expand", {"%:p"}))
end

set_keymaps({
    ['<Leader>gh'] = 'lua require"git".current_file()', -- show current file's history in tig
    ['<Leader>gg'] = 'lua require"git".status()', -- open tig in project folder
    ['<Leader>gb'] = 'Gblame', -- show commits for every source line
    ['<Leader>gp'] = '!git push', -- push
    ['<Leader>gP'] = '!git push -f', -- force push
    ['<Leader>go'] = '!hub browse', -- open in browser
    ['<Leader>gr'] = '!git pr-open' -- open pull request
  })

return {
  current_file = current_file,
  status = tig_status
}
