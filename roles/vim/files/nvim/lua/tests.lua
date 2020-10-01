local api = vim.api

api.nvim_set_keymap('n', "<leader>ra", ":TestSuite<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<leader>rt", ":TestFile<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<leader>rr", ":TestNearest<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<leader>rl", ":TestLast<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<leader>rh", ":Ttoggle<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<leader>rd", ":Tclear<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<leader>rk", ":Tkill<cr>", { silent = true, noremap = true })
