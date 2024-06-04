return {
  {
    dir = "~/Developer/replacer.nvim",
    keys = {
      {
        "<leader>h",
        function() require("replacer").run() end,
        desc = "run replacer.nvim",
      },
    },
  },
}
