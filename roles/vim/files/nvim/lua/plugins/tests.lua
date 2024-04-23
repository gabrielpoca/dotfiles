return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>ra", "<cmd>TestSuite<CR>", desc = "Run test suite" },
      { "<leader>rt", "<cmd>TestFile<CR>", desc = "Run test file" },
      { "<leader>rr", "<cmd>TestNearest<CR>", desc = "Run test line" },
      { "<leader>rl", "<cmd>TestLast<CR>", desc = "Run last test" },
    },
  },
}
