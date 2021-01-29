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

  return nil
end

M.get_chan = function(nr)
  return M.job_ids[nr]
end

M.close = function()
  wins = api.nvim_list_wins()

  for _, win in pairs(wins) do
    buf = api.nvim_win_get_buf(win)
    for _, v in pairs(M.term_buffers) do
      if v == buf then
        api.nvim_win_close(win, 1)
        return
      end
    end
  end
end

M.toggle = function()
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

  local wins = api.nvim_list_wins()

  wins = vim.tbl_filter(function(win)
    buf = api.nvim_win_get_buf(win)

    return string.match(api.nvim_buf_get_name(buf), "NERD_tree") == nil
  end, wins)

  if wins[2] == nil then
    vim.cmd("vsplit")
  end

  wins = api.nvim_list_wins()
  api.nvim_set_current_win(wins[#wins])

  if M.term_buffers[nr] and vim.fn.jobwait({ M.job_ids[nr] }, 0)[1] == -1 then
    api.nvim_set_current_buf(M.term_buffers[nr])
  else
    M.term_buffers[nr] = api.nvim_create_buf(false, false)
    api.nvim_set_current_buf(M.term_buffers[nr])
    M.job_ids[nr] = vim.fn.termopen(command)
  end

  vim.cmd("autocmd! FloatingWinLeave")
  vim.cmd("startinsert")

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
  end

  vim.cmd("autocmd! FloatingWinLeave")
  vim.cmd("startinsert")

  return { channel = M.job_ids[nr] }
end

M.floating = function(nr, command, job_opts, ...)
  M.last_used_terminal = nr

  if command == nil then
    command = "/usr/local/bin/fish"
  end

  if job_opts == nil then
    job_opts = {}
  end

  if M.term_buffers[nr] and vim.fn.jobwait({M.job_ids[nr]}, 0)[1] == -1 then
    Floating.new_buffer(M.term_buffers[nr])
  else
    M.term_buffers[nr] = api.nvim_create_buf(false, false)
    Floating.new_buffer(M.term_buffers[nr])
    M.job_ids[nr] = vim.fn.termopen(command, job_opts)
  end

  vim.cmd("augroup FloatingWinLeave")
  vim.cmd("autocmd WinLeave <buffer> :close")
  vim.cmd("augroup END")

  vim.cmd("startinsert")

  return { channel = M.job_ids[nr] }
end

set_keymaps({
    ["<leader>t"] = "lua require'terminal'.toggle()",
    ["<leader>u"] = "lua require'terminal'.side(1)",
    ["<leader>i"] = "lua require'terminal'.side(2)",
    ["<leader>U"] = "lua require'terminal'.floating(1)",
    ["<leader>I"] = "lua require'terminal'.floating(2)",
  })

vim.cmd("augroup FloatingWinLeave")
vim.cmd("augroup END")

return M
