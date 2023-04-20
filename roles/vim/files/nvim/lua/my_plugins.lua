local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {'AndrewRadev/splitjoin.vim', lazy = false},
    {'derekprior/vim-trimmer', lazy = false},
    {'embear/vim-localvimrc', lazy = false},
    {'farmergreg/vim-lastplace', lazy = false},
    {'gcmt/wildfire.vim', lazy = false},
    {'tpope/vim-abolish', lazy = false},
    {'tpope/vim-commentary', lazy = false},
    {'tpope/vim-surround', lazy = false},
    {'vim-test/vim-test', lazy = false},
    {'voldikss/vim-floaterm', lazy = false},
    {'wincent/terminus', lazy = false},
    {dir = '~/Developer/replacer.nvim'},
    {
        'gabrielpoca/term_find.nvim',
        config = function()
            require('term_find').setup({
                autocmd_pattern = 'floaterm',
                keymap_mode = 'n',
                keymap_mapping = 'gf',
                callback = function() vim.cmd("FloatermHide") end
            })
        end
    },
    {'mg979/vim-visual-multi', branch = 'master', lazy = false},
    {
        'NvChad/nvim-colorizer.lua',
        lazy = false,
        config = function() require'colorizer'.setup({}) end
    },
    {
        'phaazon/hop.nvim',
        lazy = false,
        config = function() require'hop'.setup() end,
    },
    {'kristijanhusak/any-jump.vim', lazy = false},
    {'tpope/vim-projectionist', lazy = false},
    {'christoomey/vim-tmux-navigator', lazy = false},
    {
        'romgrk/barbar.nvim',
        lazy = false,
        dependencies = {'kyazdani42/nvim-web-devicons'},
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require'nvim-tree'.setup {
                sync_root_with_cwd = true,
                disable_netrw = true,
                git = {ignore = false},
                filters = {custom = {"^\\.DS_Store"}}
            }
        end
    },
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', lazy = false},
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        config = function()
            require'treesitter-context'.setup({mode = 'topline'})
        end,
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = false,
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"svelte", "css", "typescript"},
                highlight = {enable = true},
                context_commentstring = {enable = true}
            }
        end,
    }, -----------------------------------------------------------------
    -- GIT
    -----------------------------------------------------------------
    {'tpope/vim-fugitive', lazy = false},
    {
        'pwntester/octo.nvim',
        lazy = false<,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons'
        },
        config = function() require"octo".setup() end,
    },
    -- 'morhetz/gruvbox',
    -- 'dracula/vim',
    {
        "catppuccin/nvim",
        lazy = false,
        -- as = "catppuccin",
        config = function() require('catppuccin').compile() end
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = {'kyazdani42/nvim-web-devicons'}
    },
    {'thesis/vim-solidity', ft = "solidity"},
    {'sheerun/vim-polyglot', lazy = false},
    {
        'jasonlong/vim-textobj-css',
        dependencies = 'kana/vim-textobj-user',
        lazy = false
    },
    {'tpope/vim-rails', ft = "ruby"},
    {'elixir-editors/vim-elixir', ft = "elixir"},
    {'slime-lang/vim-slime-syntax', ft = "slime"},
    {
        'andyl/vim-textobj-elixir',
        dependencies = 'kana/vim-textobj-user',
        lazy = false
    },
    {"folke/neodev.nvim", config = function() end, ft = "lua"},
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config = function()
            local actions = require('telescope.actions')

            require('telescope').setup {
                defaults = {
                    layout_strategy = 'horizontal',
                    layout_config = {height = 0.9, width = 0.9},
                    file_ignore_patterns = {
                        "node_modules",
                        "%.git/",
                        "%_build/",
                        "%.elixir%_ls",
                        "deps"
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden"
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ['<C-c>'] = actions.close,
                            ['<C-w>'] = actions.send_selected_to_qflist +
                                actions.open_qflist,
                            ['<C-q>'] = actions.send_to_qflist +
                                actions.open_qflist
                        },
                        n = {['<C-c>'] = actions.close}
                    }
                }
            }
        end
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function() require"telescope".load_extension("frecency") end,
        dependencies = {"kkharji/sqlite.lua"}
    },
    {'neovim/nvim-lspconfig'},
    {
        'williamboman/mason.nvim',
        dependencies = {'williamboman/mason-lspconfig.nvim'},
        config = function()
            require("mason").setup {ui = {icons = {package_installed = "✓"}}}
            require("mason-lspconfig").setup {automatic_installation = true}
        end
    },
    {
        'L3MON4D3/LuaSnip',
        lazy = false,
        dependencies = {"rafamadriz/friendly-snippets"},
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {"./snippets"}
            })
        end
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = false,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup {
                filetypes = {
                    javascript = true,
                    lua = true,
                    markdown = true,
                    solidity = true,
                    terraform = false,
                    typescript = true,
                    typescriptreact = true
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = false
                    -- keymap = {
                    -- accept = "<C-k>"
                    -- accept_line = "<C-K>"
                    -- accept_word = "<M-k>",
                    -- next = "<M-]>",
                    -- prev = "<M-[>",
                    -- dismiss = "<M-c>"
                    -- }
                }
            }
        end
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        lazy = false,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require("luasnip")

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                               col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                window = {},
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"})
                }),
                sources = cmp.config.sources({
                    {name = 'luasnip'},
                    {name = 'nvim_lsp'}
                }, {
                    {
                        name = 'buffer',
                        option = {
                            keyword_length = 2,
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end
                        }
                    },
                    {name = 'path'}
                })
            })

            cmp.event:on("menu_opened",
                         function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on("menu_closed",
                         function()
                vim.b.copilot_suggestion_hidden = false
            end)
        end
    },
    'folke/which-key.nvim',
    {
        'mrjones2014/legendary.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'stevearc/dressing.nvim'
        },
        config = function() require('legendary').setup() end
    }
}, {})

