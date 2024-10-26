local actions = require "fzf-lua.actions"

return {
  "ibhagwan/fzf-lua",
  opts = {
    actions = {
      files = {
        ["enter"] = actions.file_edit_or_qf,
        ["ctrl-s"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["ctrl-w"] = actions.file_sel_to_qf,
        ["ctrl-q"] = actions.close,
      },
    },
  },
}
