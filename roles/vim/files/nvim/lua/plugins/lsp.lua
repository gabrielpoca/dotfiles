return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'williamboman/mason.nvim',
            opts = {ui = {icons = {package_installed = "✓"}}},
            dependencies = {
                'williamboman/mason-lspconfig.nvim',
                opts = {automatic_installation = true}
            }
        }
    }
}
