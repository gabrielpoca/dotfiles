require("neodev").setup({})

local nvim_lsp = require('lspconfig')
local wk = require("which-key")
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
                                                                      .protocol
                                                                      .make_client_capabilities())

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    wk.register({
        l = {
            r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
            d = {
                "<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<cr>",
                "Diagnostics"
            },
            D = {
                "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
                "Workspace Diagnostics"
            },
            s = {
                "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
                "Symbols"
            },
            k = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature"},
            K = {
                '<cmd>lua vim.lsp.buf.type_definition()<CR>',
                "Jump to type definition"
            },
            l = {'<cmd>lua vim.diagnostic.open_float()<cr>', "Line Diagnostics"},
            c = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
            ['wa'] = {
                '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',
                "Add Workspace Folder"
            },
            ['wl'] = {
                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
                "List Workspace Folders"
            },
            ['wr'] = {
                '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>',
                "Remove Workspace Folder"
            }
        }
    }, {prefix = "<leader>", buffer = bufnr, nowait = true});

    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr',
                   "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
                   opts)

    -- So that the only client with format capabilities is efm
    if client.name == 'tsserver' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client.name == 'rust_analyzer' then
        vim.cmd [[
          augroup Format
            au! * <buffer>
            au BufWritePre <buffer> lua vim.lsp.buf.format({ name = 'rust_analyzer' })
          augroup END
        ]]
    elseif client.server_capabilities.documentFormattingProvider then
        vim.cmd [[
          augroup Format
            au! * <buffer>
            au BufWritePre <buffer> lua vim.lsp.buf.format({ name = 'efm' })
          augroup END
        ]]
    end
end

local do_setup = function(name, config)
    nvim_lsp[name].setup(merge({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        root_dir = nvim_lsp.util.root_pattern {".git"}
    }, config))
end

do_setup('rust_analyzer', {
    root_dir = nvim_lsp.util.root_pattern {"Cargo.toml"},
    settings = {
        ['rust-analyzer'] = {
            ['checkOnSave'] = {["enabled"] = true, ["command"] = "clippy"}
        }
    }
})

local function tsserver_root_dir()
    local tsroot = nvim_lsp.util.root_pattern("package.json")
    local tsconfigroot = nvim_lsp.util.root_pattern("tsconfig.json")
    local denoroot = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")

    return function(startpath)
        -- don't start tsserver if deno is in there
        if (denoroot(startpath)) then
            return
        else
            return tsconfigroot(startpath) or tsroot(startpath)
        end
    end
end

do_setup('tsserver',
         {root_dir = tsserver_root_dir(), single_file_support = false})

do_setup('denols',
         {root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")})

local prettier = {
    formatCommand = 'npx prettier --stdin-filepath ${INPUT}',
    formatStdin = true
}

local eslint = {
    lintCommand = "npx eslint -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"}
}

local languages = {
    css = {prettier},
    html = {prettier},
    javascript = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    json = {prettier},
    markdown = {prettier},
    scss = {
        prettier,
        {
            formatCommand = 'npx stylelint --fix --stdin --stdin-filename ${INPUT}',
            formatStdin = true
        }
    },
    typescript = {prettier, eslint},
    solidity = {
        prettier,
        {
            lintCommand = string.format('solhint -f unix -c %s ${INPUT}', vim.fn
                                            .expand(
                                            '~/.config/nvim/utils/linter-config/.solhint.json')),
            lintFormats = {'%f:%l:%c: %m'},
            lintIgnoreExitCode = true
        }
    },
    typescriptreact = {prettier, eslint},
    svelte = {prettier},
    elixir = {{formatCommand = "mix format -", formatStdin = true}},
    lua = {
        {formatCommand = "lua-format --chop-down-table -i", formatStdin = true}
    }
}

do_setup('efm', {
    root_dir = nvim_lsp.util.root_pattern {
        '.git/',
        "package.json",
        "tsconfig.json"
    },
    init_options = {documentFormatting = true, codeAction = true},
    filetypes = vim.tbl_keys(languages),
    settings = {version = 2, languages = languages}
})

do_setup('solc',
         {root_dir = nvim_lsp.util.root_pattern {'.git/', 'hardhat.config.ts'}})

nvim_lsp.lua_ls.setup({
    settings = {Lua = {completion = {callSnippet = "Replace"}}}
})

do_setup('elixirls',
         {root_dir = nvim_lsp.util.root_pattern {'.git/', 'mix.exs'}})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = {border = "single"},
    update_in_insert = false
})

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})

-- vim.lsp.handlers['textDocument/publishDiagnostics'] =
--     vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--         underline = true,
--         virtual_text = {spacing = 5, severity_limit = 'Warning'},
--         update_in_insert = true
--     })

