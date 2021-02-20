local api = vim.api

api.nvim_set_keymap('n', '<Leader>h', ':lua require("replacer").run()<cr>', { silent = true })

vim.g.any_jump_disable_default_keybindings = 1

api.nvim_set_keymap('n', '<Leader>j', ':AnyJump<cr>', { silent = true })
api.nvim_set_keymap('n', '<Leader>J', ':AnyJumpLastResults<cr>', { silent = true })
