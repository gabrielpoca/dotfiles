local terminal

local get_terminal = function()
  if not terminal then
    local Terminal = require("toggleterm.terminal").Terminal

    terminal = Terminal:new {
      count = 2,
      direction = "vertical",
      auto_scroll = false,
      start_in_insert = false,
      size = 80,
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

---@type LazySpec
return {
  "vim-test/vim-test",
  cmd = { "TestNearest", "TestFile", "TestLast", "TestClass", "TestSuite", "TestVisit" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)

        local prefix = "<Leader>r"
        maps.n[prefix] = { desc = require("astroui").get_icon("VimTest", 1, true) .. "Testing" }

        maps.n[prefix .. "r"] = { ":TestNearest<CR>", desc = "Test Nearest" }
        maps.n[prefix .. "t"] = { ":TestFile<CR>", desc = "Test File" }
        maps.n[prefix .. "l"] = { ":TestLast<CR>", desc = "Test Last" }
        maps.n[prefix .. "c"] = { ":TestClass<CR>", desc = "Test Class" }
        maps.n[prefix .. "a"] = { ":TestSuite<CR>", desc = "Test Suite" }
        maps.n[prefix .. "v"] = { ":TestVisit<CR>", desc = "Test Visit" }

        -- Set the strategy to open results in a vertical split
        if not opts.options then opts.options = {} end
        if not opts.options.g then opts.options.g = {} end

        opts.options.g["test#custom_strategies"] = {
          myrepl = function(cmd) toggle(cmd) end,
        }

        opts.options.g["test#strategy"] = "myrepl"
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { VimTest = "󰙨" } } },
  },
  event = { "VeryLazy" },
}
