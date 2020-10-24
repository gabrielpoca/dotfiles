local Terminal = require "terminal"

local function has_file(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type or false
end

local function repl_send(command)
  term = Terminal.current()
  chan = Terminal.get_chan(term)
  vim.fn.chansend(chan, command)
end

local function send_line()
  local line = vim.api.nvim_get_current_line() .. "\n"
  repl_send(line)
end

local function send_selection()
  local line1 = vim.fn.getpos("'<")[2]
  local line2 = vim.fn.getpos("'>")[2]

  local lines = ""
  for _, v in pairs(vim.fn.getline(line1, line2)) do
    lines = lines .. v .. "\n"
  end

  repl_send(lines)
end

local function start()
  filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if has_file("mix.exs") then
    repl_send('iex -S mix\n')
  end
end

local function recompile()
  filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if has_file("mix.exs") then
    repl_send('recompile\n')
  end
end

set_keymaps({
  ["<leader>es"] = "lua require'repl'.start()",
  ["<leader>er"] = "lua require'repl'.recompile()",
  ["<leader>el"] = "lua require'repl'.send_line()"
})

set_keymaps({
  ["<leader>el"] = "lua require'repl'.send_selection()"
}, 'v')

return {
  start = start,
  send = send,
  recompile = recompile,
  send_line = send_line,
  send_selection = send_selection
}
