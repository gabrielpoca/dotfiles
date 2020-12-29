local api = vim.api

api.nvim_set_keymap('n', '<Leader>h', ':lua require("replacer").run()<cr>', { silent = true })
