local Terminal = require "terminal"

local M = {}

M.has_contents = function(filename, contents, on_done)
  vim.fn.jobstart('grep ' .. contents .. ' ' .. filename, {
      on_stdout = function(_, data, _)
        on_done(vim.tbl_count(data) > 1)
      end,
      stdout_buffered = true,
      stderr_buffered = true,
    })
end

M.has_file = function(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type or false
end

M.send = function(command, terminal)
  local current_terminal = Terminal.current()

  if terminal and current_terminal ~= terminal then
    Terminal.side(terminal)

    vim.cmd("wincmd p")
    vim.api.nvim_input("<Esc>")
  elseif Terminal.current() == nil then
    Terminal.side(1)

    vim.cmd("wincmd p")
    vim.api.nvim_input("<Esc>")
  end

  local current_terminal = Terminal.current()
  local chan = Terminal.get_chan(current_terminal)
  vim.fn.chansend(chan, command)
end

M.send_line = function()
  local line = vim.api.nvim_get_current_line() .. "\n"
  M.send(line)
end

M.send_selection = function()
  local line1 = vim.fn.getpos("'<")[2]
  local line2 = vim.fn.getpos("'>")[2]

  local lines = ""
  for _, v in pairs(vim.fn.getline(line1, line2)) do
    lines = lines .. v .. "\n"
  end

  M.send(lines)
end

M.start = function()
  if M.has_file("mix.exs") then
    M.has_contents("mix.exs", "phoenix", function(res)
      if res then
        M.send('iex -S mix phx.server\n', 1)
      else
        M.has_contents("mix.exs", "still", function(res)
          if res then
            M.send('iex -S mix still.dev\n', 1)
          else
            M.send('iex -S mix\n', 1)
          end
        end)
      end
    end)
  elseif M.has_file("yarn.lock") then
    M.send("yarn start\n", 1)
  elseif M.has_file("package-lock.json") then
    M.send("npm start\n", 1)
  elseif M.has_file("Cargo.toml") then
    M.send("cargo run\n", 1)
  end
end

M.install = function()
  if M.has_file("mix.exs") then
    M.send('mix deps.get\n')
  elseif M.has_file("yarn.lock") then
    M.send("yarn install\n")
  elseif M.has_file("package-lock.json") then
    M.send("npm install\n")
  end
end

M.recompile = function()
  filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if M.has_file("mix.exs") then
    M.send('recompile\n')
  end
end

M.run_test = function(cmd)
  M.send(cmd .. "\n", 2)
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
