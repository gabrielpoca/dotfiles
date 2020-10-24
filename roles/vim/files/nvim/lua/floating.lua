local api = vim.api

local function new_buffer(buf)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_height = math.ceil(height * 4 / 5)
  local win_width

  if (width < 150) then
    win_width = math.ceil(width - 8)
  else
    win_width = math.ceil(width * 0.9)
  end

  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = math.ceil((height - win_height) / 2),
    col = math.ceil((width - win_width) / 2)
  }

  local border_opts = {
    style = "minimal",
    relative = "editor",
    row = opts.row - 1,
    col = opts.col - 1,
    width = opts.width + 2,
    height = opts.height + 2,
  }

  local border_lines = {'╭' .. string.rep('─', opts.width) .. '╮'}
  local middle_line = '│' .. string.rep(' ', opts.width) .. '│'
  for i = 1, opts.height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, '╰' .. string.rep('─', opts.width) .. '╯')

  local border_buffer = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(border_buffer, 0, -1, true, border_lines)
  local border_window = api.nvim_open_win(border_buffer, true, border_opts)
  vim.cmd 'set winhl=Normal:Floating'

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- use autocommand to ensure that the border_buffer closes at the same time as the main buffer
  local cmd = [[autocmd WinLeave <buffer> silent! execute 'silent bdelete %s']]
  vim.cmd(cmd:format(border_buffer))
end

return {
  new_buffer = new_buffer
}
