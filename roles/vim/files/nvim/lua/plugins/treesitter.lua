return {
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', lazy = false},
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        opts = {mode = 'topline'}
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = false,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "svelte",
                    "css",
                    "typescript",
                    "tsx",
                    "toml",
                    "json",
                    "yaml",
                    "html"
                },
                highlight = {enable = true},
                context_commentstring = {enable = true}
            }
        end
    },
    {
        'windwp/nvim-ts-autotag',
        lazy = false,
        config = function()
            require('nvim-ts-autotag').setup({
                autotag = {
                    enable = true,
                    enable_rename = true,
                    enable_close = true,
                    enable_close_on_slash = false,
                    filetypes = {"html", "xml"}
                }
            })
        end
    }
}
