local Terminal = require "terminal"

local M = {}

M.has_contents = function(filename, contents, on_done)
  vim.fn.jobstart('grep ' .. contents .. ' ' .. filename, {
      on_stdout = function(_, data, _)
        on_done(table_size(data) > 1)
      end,
      stdout_buffered = true,
      stderr_buffered = true,
    })
end

M.has_file = function(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type or false
end

M.repl_send = function(command)
  local term = Terminal.current()

  if term == nil then
    Terminal.side(1)
    term = Terminal.current()
  end

  local chan = Terminal.get_chan(term)
  vim.fn.chansend(chan, command)
end

M.send_line = function()
  local line = vim.api.nvim_get_current_line() .. "\n"
  M.repl_send(line)
end

M.send_selection = function()
  local line1 = vim.fn.getpos("'<")[2]
  local line2 = vim.fn.getpos("'>")[2]

  local lines = ""
  for _, v in pairs(vim.fn.getline(line1, line2)) do
    lines = lines .. v .. "\n"
  end

  M.repl_send(lines)
end

M.start = function()
  if M.has_file("mix.exs") then
    M.has_contents("mix.exs", "phoenix", function(res)
      if res then
        M.repl_send('iex -S mix phx.server\n')
      else
        M.repl_send('iex -S mix\n')
      end
    end)
  elseif M.has_file("yarn.lock") then
    M.repl_send("yarn start\n")
  elseif M.has_file("package-lock.json") then
    M.repl_send("npm start\n")
  end
end

M.install = function()
  if M.has_file("mix.exs") then
    M.repl_send('mix deps.get\n')
  elseif M.has_file("yarn.lock") then
    M.repl_send("yarn install\n")
  elseif M.has_file("package-lock.json") then
    M.repl_send("npm install\n")
  end
end

M.recompile = function()
  filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if M.has_file("mix.exs") then
    M.repl_send('recompile\n')
  end
end

set_keymaps({
  ["<leader>es"] = "lua require'repl'.start()",
  ["<leader>er"] = "lua require'repl'.recompile()",
  ["<leader>el"] = "lua require'repl'.send_line()",
  ["<leader>ei"] = "lua require'repl'.install()"
})

set_keymaps({
  ["<leader>el"] = "lua require'repl'.send_selection()"
}, 'v')

return M;
