local M = {}

M.toggle = function(terminal, cmd)
  if terminal == 1 or terminal == nil then
    name = "repl"
  else
    name = "shell"
  end

  if vim.call('floaterm#terminal#get_bufnr', name) ~= -1 then
    vim.cmd("FloatermShow " .. name)
  else
    vim.cmd("FloatermNew --name=" .. name)
  end

  if cmd then
    vim.cmd("FloatermSend --termname=" .. name .. " " .. cmd)
  end
end

vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

set_keymaps({
    ["<leader>tt"] = "FloatermToggle",
    ["<leader>tl"] = "FloatermNext",
    ["<leader>th"] = "FloatermPrev",
    ["<leader>u"] = 'lua require"terminal".toggle(2)',
    ["<leader>i"] = 'lua require"terminal".toggle(1)',
  })

return M
