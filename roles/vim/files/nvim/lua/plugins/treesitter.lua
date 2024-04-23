return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    dependencies = { "windwp/nvim-ts-autotag" },
    run = ":TSUpdate",
    lazy = false,
    init = function()
      vim.g.skip_ts_context_commentstring_module = false
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "svelte",
          "css",
          "typescript",
          "javascript",
          "tsx",
          "toml",
          "json",
          "yaml",
          "html",
          "tsx",
        },
        highlight = { enable = true },
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
        },
      })

      require("ts_context_commentstring").setup()
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
}
