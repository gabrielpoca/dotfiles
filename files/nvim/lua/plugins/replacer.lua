return {
  {
    "gabrielpoca/replacer.nvim",
    dev = vim.fn.isdirectory(vim.fn.expand "~/Developer/replacer.nvim") == 1,
    keys = {
      {
        "<leader>h",
        function() require("replacer").run() end,
        desc = "run replacer.nvim",
      },
    },
  },
}
