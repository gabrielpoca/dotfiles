return {
    {'neovim/nvim-lspconfig'},
    {
        'williamboman/mason.nvim',
        dependencies = {'williamboman/mason-lspconfig.nvim'},
        config = function()
            require("mason").setup {ui = {icons = {package_installed = "✓"}}}
            require("mason-lspconfig").setup {automatic_installation = true}
        end
    }
}
