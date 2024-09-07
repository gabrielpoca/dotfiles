local terminal

local get_terminal = function()
  if not terminal then
    local Terminal = require("toggleterm.terminal").Terminal

    terminal = Terminal:new {
      count = 2,
      direction = "float",
      auto_scroll = false,
      start_in_insert = false,
    }
  end

  return terminal
end

local toggle = function(cmd)
  local term = get_terminal()

  if not term:is_open() then term:open() end

  if cmd then
    term:send(cmd)
    vim.cmd "startinsert"
  end
end

return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>ra", "<cmd>TestSuite<CR>",                                 desc = "Run test suite" },
      { "<leader>rt", "<cmd>TestFile<CR>",                                  desc = "Run test file" },
      { "<leader>rr", "<cmd>TestNearest<CR>",                               desc = "Run test line" },
      { "<leader>rl", "<cmd>TestLast<CR>",                                  desc = "Run last test" },
      { "<Leader>tk", function() get_terminal():shutdown() end },
      { "<Leader>tv", function() get_terminal():open(100, "vertical") end },
      { "<Leader>th", function() get_terminal():open(100, "horizontal") end },
      { "<Leader>tf", function() get_terminal():open(nil, "float") end },
      { "<C-1>",      function() get_terminal():open(nil, "float") end },
    },
    config = function()
      vim.g["test#custom_strategies"] = {
        myrepl = function(cmd) toggle(cmd) end,
      }

      vim.g["test#strategy"] = "myrepl"
    end,
  },
}
