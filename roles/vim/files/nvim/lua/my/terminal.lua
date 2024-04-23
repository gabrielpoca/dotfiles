local Terminal = require("toggleterm.terminal").Terminal

local terminals = {
  shell = Terminal:new({
    count = 1,
    direction = "float",
    auto_scroll = false,
    start_in_insert = false,
  }),
  repl = Terminal:new({
    count = 2,
    direction = "float",
    auto_scroll = false,
    start_in_insert = false,
  }),
  git = Terminal:new({
    direction = "float",
    cmd = "lazygit",
    start_in_insert = true,
    hidden = true,
    on_open = function(term)
      vim.cmd("startinsert!")
      -- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  }),
}

local last_terminal = nil

local M = {}

local function get_terminal(name)
  return terminals[name]
end

M.kill = function()
  terminals["shell"]:shutdown()
  terminals["repl"]:shutdown()
  terminals["git"]:shutdown()
end

M.open_last = function()
  if last_terminal then
    last_terminal:open()
  end
end

M.toggle = function(name, cmd, opts)
  local opts = opts or {}
  local terminal = get_terminal(name)
  last_terminal = terminal

  if not terminal then
    vim.notify(string.format("Terminal %s does not exist", name), vim.log.levels.ERROR)
    return
  end

  if opts["split"] then
    dump(terminal)
    terminal:open(100, "vertical")
  else
    terminal:open(nil, "float")
  end

  if cmd then
    terminal:send(cmd)
    startinsert()
  end
end

return M
