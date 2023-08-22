return {
    {"folke/neodev.nvim", config = function() end, ft = "lua"},
    {'jose-elias-alvarez/typescript.nvim', lazy = false, keys = {}},
    {'sheerun/vim-polyglot', lazy = false},
    {'thesis/vim-solidity', lazy = false},
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
    }
}

