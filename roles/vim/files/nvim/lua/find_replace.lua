local Floating = require'floating'

local api = vim.api

local M = {}

M.all = {}

local function create_window(bufnr)
  local win_id = Floating.new_buffer(bufnr)

  vim.cmd('au WinLeave <buffer> :close')
  vim.cmd('setlocal nocursorcolumn nonumber norelativenumber')
  api.nvim_buf_set_name(bufnr, 'find_replace://' .. bufnr)
  api.nvim_buf_set_option(bufnr, 'buftype', 'acwrite')
  vim.cmd('set filetype=find_replace')

  local write_autocmd = string.format('autocmd BufWriteCmd <buffer=%s> lua require"find_replace".save(%s)', bufnr, bufnr)

  vim.api.nvim_command(write_autocmd)

  return win_id
end

M.run = function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  local items = vim.fn.getqflist()
  M.all[bufnr] = items

  local lines = {}

  for _, i in pairs(items) do
    table.insert(lines, vim.fn.bufname(i.bufnr) .. ':' .. i.text)
  end

  local win_id = create_window(bufnr)

  for i, line in pairs(lines) do
    vim.api.nvim_buf_set_lines(bufnr, i - 1, i - 1, false, {line})
  end

  vim.api.nvim_win_set_cursor(win_id, {1, 1})
  vim.api.nvim_buf_set_option(bufnr, "modified", false)
end

M.save = function(bufnr)
  vim.api.nvim_buf_set_option(bufnr, "modified", false)

  local quickfix_lines = vim.api.nvim_buf_get_lines(bufnr, 0, table_size(M.all[bufnr]), false)

  for i, item in pairs(M.all[bufnr]) do
    local line

    for j, match in pairs(vim.fn.split(quickfix_lines[i], ":")) do
      if j ~= 1 then
        if line == nil then
          line = match
        else
          line = line .. ":" .. match
        end
      end
    end

    local file = vim.fn.bufname(item.bufnr)
    local lines = vim.fn.readfile(file)
    local current_line = lines[item.lnum]

    if current_line ~= line then
      lines[item.lnum] = line
      vim.fn.writefile(lines, file)
    end
  end

  for i, item in pairs(M.all[bufnr]) do
    local new_file

    for j, match in pairs(vim.fn.split(quickfix_lines[i], ":")) do
      if j == 1 then
        new_file = match
      end
    end

    local file = vim.fn.bufname(item.bufnr)

    if file ~= new_file and vim.fn.filereadable(file) and vim.fn.filereadable(new_file) == 0 then
      vim.api.nvim_buf_delete(item.bufnr, {})
      vim.fn.mkdir(basename(new_file), "p")
      vim.fn.rename(file, new_file)
    end
  end
end

set_keymaps({
        ['<Leader>h'] = 'lua require("find_replace").run()'
    })

return M;
