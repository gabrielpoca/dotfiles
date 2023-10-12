return {
    {'AndrewRadev/splitjoin.vim', lazy = false},
    {'derekprior/vim-trimmer', lazy = false},
    {
        'embear/vim-localvimrc',
        lazy = false,
        init = function()
            vim.g.localvimrc_whitelist = {'/Users/gabriel/Developer/.*'}
        end,
        config = function() vim.g.localvimrc_sandbox = false end
    },
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
            {"<leader>rl", "<cmd>TestLast<CR>", desc = "Run last test"}
        }
    },
    {
        'voldikss/vim-floaterm',
        lazy = false,
        keys = {
            {'<leader>tt', ":FloatermToggle<CR>", desc = "Toggle terminal"},
            {'<leader>tl', ":FloatermNext<CR>", desc = "Next terminal"},
            {'<leader>th', ":FloatermPrev<CR>", desc = "Previous terminal"},
            {'<leader>tk', ":FloatermKill<CR>", desc = "Kill terminal"}
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
        opts = {
            autocmd_pattern = 'floaterm',
            keymap_mode = 'n',
            keymap_mapping = 'gf',
            callback = function() vim.cmd("FloatermHide") end
        }
    },
    {'mg979/vim-visual-multi', branch = 'master', lazy = false},
    {'NvChad/nvim-colorizer.lua', lazy = false, config = true},
    {
        'phaazon/hop.nvim',
        config = true,
        keys = {
            {'<leader>jw', '<cmd>HopWord<CR>', desc = "Go to word"},
            {'<leader>jl', '<cmd>HopLine<CR>', desc = "Go to line"}
        }
    },
    {
        'kristijanhusak/any-jump.vim',
        config = function()
            vim.g.any_jump_disable_default_keybindings = 1
        end,
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
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'kyazdani42/nvim-web-devicons'
        },
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
        opts = {
            sync_root_with_cwd = true,
            disable_netrw = true,
            git = {ignore = false},
            filters = {custom = {"^\\.DS_Store"}}
        },
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
        }
    },
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
        config = true,
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
            vim.g.floaterm_titleposition = 'center'
            vim.g.floaterm_autoinsert = false
            vim.g.floaterm_autohide = true
            -- vim.g.floaterm_title = ''
            -- vim.g.floaterm_title = ' ($1|$2) '
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = {'kyazdani42/nvim-web-devicons'}
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
        'folke/which-key.nvim',
        lazy = false,
        config = function()
            local wk = require("which-key")
            wk.register({
                b = {name = 'buffer'},
                f = {name = 'search'},
                g = {name = 'git'},
                l = {name = 'language'},
                j = {name = 'jump'},
                t = {name = 'terminal'},
                r = {name = 'tests'},
                n = {name = 'tree'},
                c = {name = 'colorscheme'}
            }, {prefix = "<leader>", nowait = true})
        end
    },
    {
        'cormacrelf/dark-notify',
        lazy = false,
        config = function()
            require('dark_notify').run({

                onchange = function(mode)
                    if mode == 'light' then
                        os.execute(
                            "sed -i '' -e \"s/^colors: .*$/colors: *catppuccin_latte/\" $DOTFILES/roles/shell/files/alacritty/alacritty.yml")
                        os.execute(
                            "kitty +kitten themes --reload-in=all Catppuccin Kitty Latte")
                    else
                        os.execute(
                            "sed -i '' -e \"s/^colors: .*$/colors: *catppuccin_mocha/\" $DOTFILES/roles/shell/files/alacritty/alacritty.yml")
                        os.execute(
                            "kitty +kitten themes --reload-in=all Catppuccin Kitty Mocha")
                    end
                end
            })
        end
    }
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     -- lazy = false,
    --     opts = {
    --         -- add any options here
    --     },
    --     dependencies = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         -- OPTIONAL:
    --         --   `nvim-notify` is only needed, if you want to use the notification view.
    --         --   If not available, we use `mini` as the fallback
    --         "rcarriga/nvim-notify"
    --     },

    --     config = function()
    --         require("noice").setup({
    --             lsp = {
    --                 -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --                 override = {
    --                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                     ["vim.lsp.util.stylize_markdown"] = true,
    --                     ["cmp.entry.get_documentation"] = true
    --                 }
    --             },
    --             -- you can enable a preset for easier configuration
    --             presets = {
    --                 bottom_search = true, -- use a classic bottom cmdline for search
    --                 command_palette = true, -- position the cmdline and popupmenu together
    --                 long_message_to_split = true, -- long messages will be sent to a split
    --                 inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --                 lsp_doc_border = false -- add a border to hover docs and signature help
    --             }
    --         })
    --     end
    -- }
}
