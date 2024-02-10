local Terminal = require("my.terminal")

local api = vim.api

local M = {}

M.status = function()
  Terminal.toggle("git")
end

M.file_history = function()
  Terminal.toggle("shell", "tig " .. api.nvim_call_function("expand", { "%:p" }))
end

vim.keymap.set("n", "<leader>gs", M.status)
vim.keymap.set("n", "<leader>gh", M.file_history)

return M
