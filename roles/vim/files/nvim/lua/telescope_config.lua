local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "_build", ".elixir_ls" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ['<C-c>'] = actions.close
      },
      n = {
        ['<C-c>'] = actions.close,
      }
    },
  },
}
