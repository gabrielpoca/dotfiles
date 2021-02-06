local Floating = require'floating'

local api = vim.api

local M = {}

local function create_ci_status_popup()
  local buf = vim.api.nvim_create_buf(false, true)
  local win_id = Floating.new_buffer(buf, { height = 10, width = 60, position = 'topright' })
  vim.cmd("au WinLeave <buffer> :close")
  vim.cmd('setlocal nocursorcolumn nonumber norelativenumber')

  for i = 0, 8 do
    vim.api.nvim_buf_set_lines(buf, i, i, false, {""})
  end

  vim.api.nvim_win_set_cursor(win_id, {1, 1})

  return buf
end

M.run = function()
  local stdout = vim.loop.new_pipe(false) -- create file descriptor for stdout
  local stderr = vim.loop.new_pipe(false) -- create file descriptor for stdout
  local buf = nil
  local current_line = 0

  handle = vim.loop.spawn('hub', {
      args = {'ci-status', '-v'},
      stdio = {stdout,stderr}
    },
    function()
      stdout:read_stop()
      stderr:read_stop()
      stdout:close()
      stderr:close()
      handle:close()
    end
    )

  local on_read = vim.schedule_wrap(function (err, data)
    if err then
      dump(err)
    end

    if data == nil then
      return
    end

    local lines = vim.split(data, "\n")

    lines = vim.tbl_filter(function(v)
      return v ~= "" and v ~= nil
    end, lines)

    lines = vim.tbl_map(function(line)
      local parts = vim.split(line, "\t")
      return parts[1] .. " " .. parts[2]
    end, lines)

    local size = vim.tbl_count(lines)

    buf = buf or create_ci_status_popup()
    vim.api.nvim_buf_set_lines(buf, current_line, vim.tbl_count(lines) + current_line, false, lines)
    current_line = current_line + size
  end)

  vim.loop.read_start(stdout, on_read)
  vim.loop.read_start(stderr, on_read)
end

set_keymaps({
    ['<Leader>gi'] = 'lua require"ci_status".run()', -- show the current branch's CI status
  })

return M
