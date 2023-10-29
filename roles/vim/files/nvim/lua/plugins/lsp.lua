return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			opts = { ui = { icons = { package_installed = "✓" } } },
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				opts = { automatic_installation = true },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
	},
}
