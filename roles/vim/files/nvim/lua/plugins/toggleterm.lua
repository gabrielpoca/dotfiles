local terminal

local get_terminal = function()
  if not terminal then
    local Terminal = require("toggleterm.terminal").Terminal

    terminal = Terminal:new {
      count = 3,
      direction = "float",
      auto_scroll = false,
      start_in_insert = false,
    }
  end

  return terminal
end

local toggle = function(cmd)
  get_terminal():open()

  if cmd then
    get_terminal():send(cmd)
    vim.cmd "startinsert"
  end
end

local has_file = function(filename)
  local stat = vim.loop.fs_stat(filename)

  return stat and stat.type or false
end

local includes = function(filename, contents, on_done)
  vim.fn.jobstart("grep " .. contents .. " " .. filename, {
    on_stdout = function(_, data, _) on_done(vim.tbl_count(data) > 1) end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<Leader>yk", function() get_terminal():shutdown() end },
      { "<Leader>yv", function() get_terminal():open(100, "vertical") end },
      { "<Leader>yh", function() get_terminal():open(100, "horizontal") end },
      { "<Leader>yf", function() get_terminal():open(nil, "float") end },
      {
        "<Leader>ys",
        function()
          if has_file "mix.exs" then
            includes("mix.exs", "phoenix", function(result)
              if result then
                toggle "iex -S mix phx.server\n"
              else
                includes("mix.exs", "still", function(result)
                  if result then
                    toggle "iex -S mix still.dev\n"
                  else
                    toggle "iex -S mix\n"
                  end
                end)
              end
            end)
          elseif has_file "Justfile" then
            toggle "just dev\n"
          elseif has_file "yarn.lock" then
            includes("package.json", '"dev"', function(result)
              if result then
                toggle "yarn run dev\n"
              else
                toggle "yarn start\n"
              end
            end)
          elseif has_file "package-lock.json" then
            includes("package.json", '"dev"', function(result)
              if result then
                toggle "npm run dev\n"
              else
                toggle "npm start\n"
              end
            end)
          elseif has_file "Cargo.toml" then
            toggle "cargo run\n"
          else
            error "Failed to identify server"
          end
        end,
        desc = "ToggleTerm server",
      },
    },
  },
}
