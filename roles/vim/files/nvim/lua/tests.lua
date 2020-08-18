vim.api.nvim_set_keymap('n', "<leader>ra", ":TestSuite<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', "<leader>rt", ":TestFile<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', "<leader>rr", ":TestNearest<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', "<leader>rl", ":TestLast<cr>", { silent = true, noremap = true })
