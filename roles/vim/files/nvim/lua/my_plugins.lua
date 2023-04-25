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
    {
        'vim-test/vim-test',
        keys = {
            {"<leader>ra", "<cmd>TestSuite<CR>", desc = "Run test suite"},
            {"<leader>rt", "<cmd>TestFile<CR>", desc = "Run test file"},
            {"<leader>rr", "<cmd>TestNearest<CR>", desc = "Run test line"},
            {"<leader>rl", "<cmd>TestLast<CR>", desc = "Run last test"},
            {"<leader>rd", "<cmd>Tclear<CR>", desc = "Clear terminal"},
            {"<leader>rk", "<cmd>Tkill<CR>", desc = "Kill job"}
        }
    },
    {
        'voldikss/vim-floaterm',
        lazy = false,
        keys = {
            {'<leader>tt', ":FloatermToggle<CR>", desc = "Toggle terminal"},
            {'<leader>tl', ":FloatermNext<CR>", desc = "Next terminal"},
            {'<leader>th', ":FloatermPrev<CR>", desc = "Previous terminal"}
        }
    },
    {'wincent/terminus', lazy = false},
    {
        dir = '~/Developer/replacer.nvim',
        keys = {
            {
                '<leader>h',
                function() require('replacer').run() end,
                desc = "run replacer.nvim"
            }
        }
    },
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
        config = function() require'hop'.setup() end,
        keys = {
            {'<leader>jw', '<cmd>HopWord<CR>', desc = "Go to word"},
            {'<leader>jl', '<cmd>HopLine<CR>', desc = "Go to line"}
        }
    },
    {
        'kristijanhusak/any-jump.vim',
        keys = {
            {'<leader>jj', "<cmd>AnyJump<CR>", desc = "AnyJump"},
            {
                '<leader>jk',
                "<cmd>AnyJumpLastResults<CR>",
                desc = "AnyJump Reopen"
            }
        }
    },
    {
        'tpope/vim-projectionist',
        lazy = false,
        keys = {
            {'<leader>a', "<cmd>A<CR>", desc = "Change to alternate"},
            {'<leader>v', "<cmd>AV<CR>", desc = "Open alternate file in split"}
        }
    },
    {'christoomey/vim-tmux-navigator', lazy = false},
    {
        'romgrk/barbar.nvim',
        lazy = false,
        dependencies = {'kyazdani42/nvim-web-devicons'},
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {insert_at_start = true},
        keys = {
            {"<leader>1", ":BufferGoto 1<CR>", desc = "Go to buffer 1"},
            {"<leader>2", ":BufferGoto 2<CR>", desc = "Go to buffer 2"},
            {"<leader>3", ":BufferGoto 3<CR>", desc = "Go to buffer 3"},
            {"<leader>4", ":BufferGoto 4<CR>", desc = "Go to buffer 4"},
            {"<leader>5", ":BufferGoto 5<CR>", desc = "Go to buffer 5"},
            {"<leader>6", ":BufferGoto 6<CR>", desc = "Go to buffer 6"},
            {"<leader>7", ":BufferGoto 7<CR>", desc = "Go to buffer 7"},
            {'<leader>bn', ":BufferNext<CR>", desc = "Next"},
            {'<leader>bp', ":BufferPrevious<CR>", desc = "Previous"},
            {'<leader>bq', ":BufferClose<CR>", desc = "Close"},
            {
                '<leader>bb',
                ":BufferOrderByBufferNumber<CR>",
                desc = "Order by number"
            },
            {
                '<leader>bd',
                ":BufferOrderByDirectory<CR>",
                desc = "Order by directory"
            },
            {
                '<leader>bl',
                ":BufferOrderByLanguage<CR>",
                desc = "Order by language"
            },
            {'<leader>bo', ":BufferPick<CR>", desc = "Pick buffer"}
        }
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
        keys = {
            {
                '<leader>nn',
                function() require('nvim-tree.api').tree.toggle() end,
                desc = "Toggle"
            },
            {
                '<leader>nf',
                function()
                    require('nvim-tree.api').tree.find_file({
                        open = true,
                        focus = true
                    })
                end,
                desc = "Find file"
            }
        },
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
        'RRethy/vim-illuminate',
        lazy = false,
        config = function()
            require('illuminate').configure({
                filetypes_denylist = {'NvimTree'},
                min_count_to_highlight = 2
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        config = function()
            require'treesitter-context'.setup({mode = 'topline'})
        end
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
        end
    },
    {
        'tpope/vim-fugitive',
        cmd = "G",
        keys = {
            {'<leader>gs', "<cmd>vertical G<CR>", desc = "Git status"},
            {'<leader>gb', "<cmd>G blame<CR>", desc = "Git blame"},
            {'<leader>gp', "<cmd>G push<CR>", desc = "Git push"},
            {'<leader>go', "<cmd>G browse<CR>", desc = "Git browse"},
            {
                '<leader>gh',
                function() require('git').file_history() end,
                desc = "Git history for file"
            }
        }
    },
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons'
        },
        config = function() require"octo".setup() end,
        cmd = 'Octo',
        keys = {{'<leader>gP', "<cmd>Octo pr list<CR>", desc = "List PRs"}}
    },
    -- 'morhetz/gruvbox',
    -- 'dracula/vim',
    {
        "catppuccin/nvim",
        lazy = false,
        config = function()
            require('catppuccin').compile()
            require('catppuccin').setup({
                integrations = {
                    which_key = true,
                    barbar = true,
                    hop = true,
                    mason = true,
                    cmp = true,
                    native_lsp = false,
                    nvimtree = true,
                    treesitter = true,
                    octo = true,
                    telescope = true,
                    illuminate = true

                }
            })

            vim.g.floaterm_width = 0.9
            vim.g.floaterm_height = 0.9
            -- vim.g.floaterm_borderchars = '        '
            vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
            vim.g.floaterm_title = ''
            -- vim.g.floaterm_title = ' term ($1|$2) '
            vim.g.floaterm_autoinsert = false
            vim.g.floaterm_autohide = true
        end
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
        keys = {
            {
                '<leader>o',
                function()
                    local telescope = require('telescope.builtin')
                    telescope.buffers();
                end,
                desc = "Buffers"
            },
            {
                '<leader>p',
                function()
                    local telescope = require('telescope.builtin')
                    telescope.find_files({hidden = true});
                end,
                desc = "Files"
            },
            {
                '<leader>P',
                function()
                    require('telescope').extensions.frecency.frecency({
                        workspace = 'CWD'
                    });
                end,
                desc = "Recent Files"
            },
            {
                '<leader>fw',
                function()
                    local telescope = require('telescope.builtin')
                    telescope.grep_string();
                end,
                desc = "Search for word under cursor"
            },
            {
                '<leader>ff',
                function()
                    local telescope = require('telescope.builtin')
                    telescope.grep_string({search = ''});
                end,
                desc = "Search for input"
            }
        },
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
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            {
                '<leader>cc',
                function() require('copilot.panel').open({}) end,
                desc = "Copilot"
            }
        },
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
    {
        'folke/which-key.nvim',
        lazy = false,
        config = function()
            local wk = require("which-key")
            wk.register({
                b = {name = 'buffer'},
                c = {name = 'shell'},
                f = {name = 'search'},
                g = {name = 'git'},
                j = {name = 'jump'},
                t = {name = 'terminal'},
                r = {name = 'tests'},
                n = {name = 'tree'}
            }, {prefix = "<leader>", nowait = true})
        end
    },
    {
        'mrjones2014/legendary.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'stevearc/dressing.nvim'
        },
        config = function() require('legendary').setup() end,
        keys = {
            {
                '<leader><leader>',
                function() require('legendary').find() end,
                desc = "Search everything"
            }
        }
    }
}, {})

local wk = require("which-key")

local wk_mappings = {
    e = {
        name = "shell",
        s = {function() require'repl'.start() end, "Start server"},
        r = {function() require'repl'.recompile() end, "Recompile"},
        l = {function() require'repl'.send_line() end, "Send line"},
        i = {function() require'repl'.install() end, "Setup projet"}
    },
    i = {function() require"terminal".toggle(1) end, "General terminal"},
    u = {function() require"terminal".toggle(2) end, "Tests terminal"}
}

wk.register(wk_mappings, {prefix = "<leader>", nowait = true})
