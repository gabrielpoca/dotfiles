local nvim_lsp = require('lspconfig')
local coq = require('coq')
local wk = require("which-key")

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
            name = "Language",
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
            l = {
                '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<cr>',
                "Line Diagnostics"
            },
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
        client.resolved_capabilities.document_formatting = false
    end

    if client.resolved_capabilities.document_formatting then
        vim.cmd [[
          augroup Format
            au! * <buffer>
            au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000)
          augroup END
        ]]
    end
end

local do_setup = function(name, config)
    nvim_lsp[name].setup(coq.lsp_ensure_capabilities(merge({
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        root_dir = nvim_lsp.util.root_pattern {".git"}
    }, config)))
end

do_setup('rust_analyzer', {root_dir = nvim_lsp.util.root_pattern {"Cargo.toml"}})

do_setup('solidity_ls', {
    root_dir = nvim_lsp.util.root_pattern {
        '.git/', "package.json", "tsconfig.json"
    },
    init_options = {codeAction = true}
})

do_setup('tsserver', {
    root_dir = nvim_lsp.util
        .root_pattern {'.git/', "package.json", "tsconfig.json"}
})

local prettier = {
    formatCommand = 'npx prettierd "${INPUT}"',
    formatStdin = true,
    env = {
        string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn
                          .expand(
                          '~/.config/nvim/utils/linter-config/.prettierrc.json'))
    }
}

local languages = {
    css = {prettier},
    html = {prettier},
    javascript = {prettier},
    javascriptreact = {prettier},
    json = {prettier},
    markdown = {prettier},
    scss = {prettier},
    scss = {prettier},
    typescript = {prettier},
    solidity = {
        prettier, {
            lintCommand = string.format('solhint -f unix -c %s ${INPUT}', vim.fn
                                            .expand(
                                            '~/.config/nvim/utils/linter-config/.solhint.json')),
            lintFormats = {'%f:%l:%c: %m'}
        }
    },
    typescriptreact = {prettier},
    svelte = {prettier},
    lua = {{formatCommand = "lua-format -i", formatStdin = true}}
}

do_setup('efm', {
    root_dir = nvim_lsp.util.root_pattern {
        '.git/', "package.json", "tsconfig.json"
    },
    init_options = {documentFormatting = true, codeAction = true},
    filetypes = vim.tbl_keys(languages),
    settings = {version = 2, languages = languages}
})

do_setup('elixirls',
         {root_dir = nvim_lsp.util.root_pattern {'.git/', 'mix.exs'}})

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = false,
        update_in_insert = false
    })
