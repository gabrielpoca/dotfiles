require('packer', {git = {clone_timeout = 120}}).startup(function()
    use 'wbthomason/packer.nvim'

    use 'AndrewRadev/splitjoin.vim'
    use 'antoinemadec/FixCursorHold.nvim'
    use 'derekprior/vim-trimmer'
    use 'embear/vim-localvimrc'
    use 'farmergreg/vim-lastplace'
    use 'gcmt/wildfire.vim'
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'vim-test/vim-test'
    use 'voldikss/vim-floaterm'
    use 'wincent/terminus'
    use '~/Developer/replacer.nvim'
    use {
        'gabrielpoca/term_find.nvim',
        config = function()
            require('term_find').setup({
                autocmd_pattern = 'floaterm',
                keymap_mode = 'n',
                keymap_mapping = 'gf',
                callback = function() vim.cmd("FloatermHide") end
            })
        end
    }
    use {'mg979/vim-visual-multi', branch = 'master'}

    -----------------------------------------------------------------
    -- Navigation
    -----------------------------------------------------------------
    use {'phaazon/hop.nvim', config = function() require'hop'.setup() end}
    use 'kristijanhusak/any-jump.vim'
    use 'tpope/vim-projectionist'
    use 'christoomey/vim-tmux-navigator'
    use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-tree'.setup {
                sync_root_with_cwd = true,
                disable_netrw = true,
                git = {ignore = false},
                filters = {custom = {"^\\.DS_Store"}}
            }
        end
    }

    -----------------------------------------------------------------
    -- Treesitter
    -----------------------------------------------------------------
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"svelte", "css", "typescript"},
                highlight = {enable = true},
                context_commentstring = {enable = true}
            }
        end
    }

    -----------------------------------------------------------------
    -- GIT
    -----------------------------------------------------------------
    use 'tpope/vim-fugitive'
    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons'
        },
        config = function() require"octo".setup() end
    }

    -----------------------------------------------------------------
    -- Colors
    -----------------------------------------------------------------
    -- use 'morhetz/gruvbox'
    -- use 'dracula/vim'
    use {"catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile"}
    use 'vimpostor/vim-tpipeline'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -----------------------------------------------------------------
    -- Languages
    -----------------------------------------------------------------
    use 'thesis/vim-solidity'
    use 'sheerun/vim-polyglot'
    use {'jasonlong/vim-textobj-css', requires = 'kana/vim-textobj-user'}
    use 'tpope/vim-rails'
    use 'elixir-editors/vim-elixir'
    use 'slime-lang/vim-slime-syntax'
    use {'andyl/vim-textobj-elixir', requires = 'kana/vim-textobj-user'}
    use 'tjdevries/nlua.nvim'

    -----------------------------------------------------------------
    -- Fuzzy finder
    -----------------------------------------------------------------
    use {'junegunn/fzf', run = './install --all'}
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config = function()
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        "node_modules", "%.git/", "_build", ".elixir_ls", "deps"
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ['<C-c>'] = actions.close
                        },
                        n = {['<C-c>'] = actions.close}
                    }
                }
            }
        end
    }

    -----------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------
    use {
        'neovim/nvim-lspconfig',
        requires = {'williamboman/nvim-lsp-installer'},
        config = function()
            require("nvim-lsp-installer").setup {automatic_installation = true}
        end
    }

    -----------------------------------------------------------------
    -- Completion
    -----------------------------------------------------------------
    use {
        'L3MON4D3/LuaSnip',
        requires = {"rafamadriz/friendly-snippets"},
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {"./snippets"}
            })
        end
    }

    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'
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
                    {name = 'luasnip'}, {name = 'nvim_lsp'}
                }, {{name = 'buffer'}})
            })
        end
    }

    -----------------------------------------------------------------
    -- Commands
    -----------------------------------------------------------------
    use 'folke/which-key.nvim'
    use {
        'mrjones2014/legendary.nvim',
        requires = {'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim'},
        config = function() require('legendary').setup() end
    }
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost my_plugins.lua source <afile> | PackerCompile
  augroup end
]])
