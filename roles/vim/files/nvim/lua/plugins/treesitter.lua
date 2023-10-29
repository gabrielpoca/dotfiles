return {
	{
		"nvim-treesitter/nvim-treesitter",
		main = "nvim-treesitter.configs",
		dependencies = { "windwp/nvim-ts-autotag" },
		run = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"astro",
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
				autotag = { enable = true },
				context_commentstring = { enable = true },
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
					-- filetypes = { "html", "xml" },
				},
			})
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
}
