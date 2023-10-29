return {
	{ "farmergreg/vim-lastplace", lazy = false },
	{ "mg979/vim-visual-multi", branch = "master", lazy = false },
	{
		"phaazon/hop.nvim",
		config = true,
		keys = {
			{ "<leader>jw", "<cmd>HopWord<CR>", desc = "Go to word" },
			{ "<leader>jl", "<cmd>HopLine<CR>", desc = "Go to line" },
		},
	},
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{
		"kristijanhusak/any-jump.vim",
		config = function()
			vim.g.any_jump_disable_default_keybindings = 1
		end,
		keys = {
			{ "<leader>jj", "<cmd>AnyJump<CR>", desc = "AnyJump" },
			{
				"<leader>jk",
				"<cmd>AnyJumpLastResults<CR>",
				desc = "AnyJump Reopen",
			},
		},
	},
	{
		"tpope/vim-projectionist",
		init = function()
			vim.g.projectionist_heuristics = {
				["foundry.toml"] = {
					["src/*.sol"] = { ["alternate"] = "test/{}.t.sol", ["type"] = "source" },
					["test/*.t.sol"] = { ["alternate"] = "src/{}.sol", ["type"] = "test" },
				},
				["Gemfile"] = {
					["app/*.rb"] = { ["alternate"] = "spec/{}_spec.rb", ["type"] = "source" },
					["spec/*_spec.rb"] = { ["alternate"] = "app/{}.rb", ["type"] = "test" },
				},
				["spec/support/jasmine.json"] = {
					["src/*.js"] = { ["alternate"] = "src/{}.spec.js", ["type"] = "source" },
					["src/*.spec.js"] = { ["alternate"] = "src/{}.js", ["type"] = "test" },
				},
				["package.json"] = {
					["src/*/index.jsx"] = {
						["alternate"] = "src/{}/index.module.scss",
						["type"] = "js",
					},
					["src/*/index.module.scss"] = {
						["alternate"] = "src/{}/index.jsx",
						["type"] = "css",
					},
					["src/*.js"] = { ["alternate"] = "{}.test.js", ["type"] = "source" },
					["src/*.test.js"] = { ["alternate"] = "src/{}.js", ["type"] = "test" },
				},
				["mix.exs"] = {
					["lib/*_live.ex"] = {
						["alternate"] = "lib/{}_live.html.leex",
						["type"] = "source",
					},
					["lib/*.ex"] = { ["alternate"] = "test/{}_test.exs", ["type"] = "source" },
					["test/*_test.exs"] = { ["alternate"] = "lib/{}.ex", ["type"] = "test" },
					["lib/*.html.leex"] = {
						["alternate"] = "lib/{}.ex",
						["type"] = "live_view",
					},
				},
			}
		end,
		keys = {
			{ "<leader>a", "<cmd>A<CR>", desc = "Change to alternate" },
			{ "<leader>v", "<cmd>AV<CR>", desc = "Open alternate file in split" },
		},
	},
}
