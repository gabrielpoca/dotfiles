return {
  {
    "sheerun/vim-polyglot",
    lazy = false,
    init = function()
      vim.g.polyglot_disabled = { "solidity", "svelte" }
      vim.g.svelte_preprocessors = { "typescript" }
      vim.g.terraform_fmt_on_save = 1
      vim.g.typescript_indent_disable = 1
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_folding_disabled = 1
    end,
  },
  { "thesis/vim-solidity", ft = "solidity" },
  {
    "rhysd/vim-textobj-anyblock",
    dependencies = "kana/vim-textobj-user",
    lazy = false,
  },
  { "tpope/vim-rails", ft = "ruby" },
  { "slime-lang/vim-slime-syntax", ft = "slime" },
  {
    "andyl/vim-textobj-elixir",
    dependencies = "kana/vim-textobj-user",
    ft = "elixir",
  },
  {
    "folke/neodev.nvim",
    opts = {
      lspconfig = true,
    },
  },
  "Glench/Vim-Jinja2-Syntax",
}
