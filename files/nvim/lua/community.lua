-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  { import = "astrocommunity.git.openingh-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.completion.supermaven-nvim" },
  { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.editing-support.mini-splitjoin" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.hop-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.pack.elixir-phoenix" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.recipes.vscode" },
}
