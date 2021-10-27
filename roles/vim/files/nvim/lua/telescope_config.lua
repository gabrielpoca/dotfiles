local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

function fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist(prompt_bufnr)
  else
    actions.file_edit(prompt_bufnr)
  end
end

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "_build", ".elixir_ls" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ['<cr>'] = fzf_multi_select,
        ['<C-c>'] = actions.close
      },
      n = {
        ['<C-c>'] = actions.close,
        ['<cr>'] = fzf_multi_select
      }
    },
  },
}

set_keymap('n', '<leader>lr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
set_keymap('n', '<leader>la', "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>")
set_keymap('n', '<leader>ld', "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>")
set_keymap('n', '<leader>lD', "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>")
set_keymap('n', '<leader>lr', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>")
set_keymap('n', '<leader>lR', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>")
