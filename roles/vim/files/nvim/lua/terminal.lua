local Floating = require "./floating"

local api = vim.api

local M = {}

M.term_buffers = {}
M.job_ids = {}
M.last_used_terminal = nil;

M.current = function()
  wins = api.nvim_list_wins()

  for _, win in pairs(wins) do
    buf = api.nvim_win_get_buf(win)

    for nr, v in pairs(M.term_buffers) do
      if v == buf then
        return nr
      end
    end
  end
end

M.get_chan = function(nr)
  return M.job_ids[nr]
end

M.hide_terminal = function()
  local found = false

  wins = api.nvim_list_wins()

  for _, win in pairs(wins) do
    buf = api.nvim_win_get_buf(win)
    for _, v in pairs(M.term_buffers) do
      if v == buf then
        found = true
        api.nvim_win_close(win, 1)
      end
    end
  end

  if found == false and M.last_used_terminal then
    M.side(M.last_used_terminal)
  end
end

M.side = function(nr, command, ...)
  M.last_used_terminal = nr

  if command == nil then
    command = "/usr/local/bin/fish"
  end

  wins = api.nvim_list_wins()

  if wins[2] == nil then
    vim.cmd(":vsplit")
  end

  wins = api.nvim_list_wins()
  api.nvim_set_current_win(wins[#wins])

  if M.term_buffers[nr] and vim.fn.jobwait({ M.job_ids[nr] }, 0)[1] == -1 then
    api.nvim_set_current_buf(M.term_buffers[nr])
  else
    M.term_buffers[nr] = api.nvim_create_buf(false, false)
    api.nvim_set_current_buf(M.term_buffers[nr])
    M.job_ids[nr] = vim.fn.termopen(command)
    vim.cmd 'set winhl=Normal:Floating'
  end

  vim.cmd(":startinsert")

  return { channel = M.job_ids[nr] }
end

M.tab = function(nr, command, ...)
  M.last_used_terminal = nr

  if command == nil then
    command = "/usr/local/bin/fish"
  end

  vim.cmd "tabnew"

  if M.term_buffers[nr] and vim.fn.jobwait({M.job_ids[nr]}, 0)[1] == -1 then
    api.nvim_set_current_buf(M.term_buffers[nr])
  else
    M.term_buffers[nr] = api.nvim_create_buf(false, false)
    api.nvim_set_current_buf(M.term_buffers[nr])
    M.job_ids[nr] = vim.fn.termopen(command)
    vim.cmd 'set winhl=Normal:Floating'
  end

  vim.cmd(":startinsert")

  return { channel = M.job_ids[nr] }
end

M.floating = function(nr, command, ...)
  M.last_used_terminal = nr

  if command == nil then
    command = "/usr/local/bin/fish"
  end

  if M.term_buffers[nr] and vim.fn.jobwait({M.job_ids[nr]}, 0)[1] == -1 then
    Floating.new_buffer(M.term_buffers[nr])
  else
    M.term_buffers[nr] = api.nvim_create_buf(false, false)
    Floating.new_buffer(M.term_buffers[nr])
    M.job_ids[nr] = vim.fn.termopen(command)
    vim.cmd(":au WinLeave <buffer> :close")
  end

  vim.cmd(":startinsert")

  return { channel = M.job_ids[nr] }
end

set_keymaps({
    ["<leader>th"] = "lua require'terminal'.hide_terminal()",
    -- side terminals
    ["<leader>tu"] = "lua require'terminal'.side(1)",
    ["<leader>ti"] = "lua require'terminal'.side(2)",
    ["<leader>to"] = "lua require'terminal'.side(3)",
    ["<leader>tp"] = "lua require'terminal'.side(4)",
    -- floating terminals
    ["<leader>fu"] = "lua require'terminal'.floating(1)",
    ["<leader>fi"] = "lua require'terminal'.floating(2)",
    ["<leader>fo"] = "lua require'terminal'.floating(3)",
    ["<leader>fp"] = "lua require'terminal'.floating(4)"
  })

return M
