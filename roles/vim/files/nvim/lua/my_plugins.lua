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
    use 'gabrielpoca/term_find.nvim'
    use {'mg979/vim-visual-multi', branch = 'master'}

    -----------------------------------------------------------------
    -- Navigation
    -----------------------------------------------------------------
    use {'phaazon/hop.nvim', config = function() require'hop'.setup() end}
    use 'kristijanhusak/any-jump.vim'
    use 'tpope/vim-projectionist'
    use 'christoomey/vim-tmux-navigator'
    use 'vimpostor/vim-tpipeline'
    use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-tree'.setup {
                sync_root_with_cwd = true,
                disable_netrw = true,
                git = {ignore = false}
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
                        "node_modules", ".git", "_build", ".elixir_ls"
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
    -- Completion
    -----------------------------------------------------------------
    use {'github/copilot.vim'}
    use {'ms-jpq/coq_nvim', branch = 'coq'}
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
    use {
        'ms-jpq/coq.thirdparty',
        requires = {'ms-jpq/coq_nvim'},
        config = function()
            require("coq_3p") {
                {src = "nvimlua", short_name = "nLUA"},
                {src = "copilot", short_name = "COP", accept_key = "<c-f>"}
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
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            vim.diagnostic.config({virtual_text = false})
            require("lsp_lines").setup()
        end
    }

    -----------------------------------------------------------------
    -- Commands
    -----------------------------------------------------------------
    use 'folke/which-key.nvim'
    use {
        'mrjones2014/legendary.nvim',
        requires = {'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim'}
    }
end)
