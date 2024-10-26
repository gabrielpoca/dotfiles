return {
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function() vim.o.background = "dark" end,
      set_light_mode = function() vim.o.background = "light" end,
    },
  },
}
