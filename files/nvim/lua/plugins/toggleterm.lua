local terminals = {}

local get_terminal = function(globalcount)
  local count = globalcount or 3

  if not terminals[count] then
    local Terminal = require("toggleterm.terminal").Terminal

    terminals[count] = Terminal:new {
      count = count,
      direction = "float",
      auto_scroll = false,
      start_in_insert = false,
    }
  end

  return terminals[count]
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

local smart_toggle = function(count)
  local term = get_terminal(count)

  if term:is_open() then
    local current_buf = vim.api.nvim_get_current_buf()
    local term_buf = term.bufnr

    if current_buf == term_buf then
      term:toggle()
    else
      term:focus()
    end
  else
    local cols = vim.o.columns
    local min_cols_for_vertical = 120

    if cols >= min_cols_for_vertical then
      vim.cmd "wincmd t"
      local size = math.min(220, math.floor(cols * 0.5))
      term:open(size, "vertical")
    else
      term:open(nil, "float")
    end
  end
end

return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = "<C-t>",
    size = function(term)
      if term.direction == "horizontal" then
        return 25
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    responsiveness = {
      horizontal_breakpoint = 160,
    },
  },
  keys = {
    { "<Leader>yk", function() get_terminal():shutdown() end },
    { "<Leader>yv", function() get_terminal():open(100, "vertical") end },
    { "<Leader>yh", function() get_terminal():open(100, "horizontal") end },
    { "<Leader>yf", function() get_terminal():open(nil, "float") end },
    { "<Leader>yy", function() get_terminal():open() end },
    -- { "<A-k>", function() smart_toggle(3) end },
    -- { "<A-k>", function() smart_toggle(3) end, mode = "t" },
    -- { "<A-j>", function() smart_toggle(4) end },
    -- { "<A-j>", function() smart_toggle(4) end, mode = "t" },
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
          vim.notify("Failed to identify server to start", vim.log.levels.ERROR, { title = "Terminal" })
        end
      end,
      desc = "ToggleTerm server",
    },
  },
}
