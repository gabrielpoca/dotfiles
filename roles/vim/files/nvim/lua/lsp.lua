local nvim_lsp = require('lspconfig')
local coq = require('coq')

require("coq_3p") {
  {
    src = "repl",
    shell = { n = "node", r = "ruby" },
    max_lines = 99,
    deadline = 500,
    unsafe = { "rm", "poweroff", "mv" }
  },
  { src = "nvimlua", short_name = "nLUA" },
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<cr>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

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

vim.schedule(function ()
  nvim_lsp.tsserver.setup(coq().lsp_ensure_capabilities{
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern { '.git/', '.' },
    flags = {
      debounce_text_changes = 150,
    }
  })

  nvim_lsp.solargraph.setup(coq().lsp_ensure_capabilities{
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern { '.git/', '.' },
    flags = {
      debounce_text_changes = 150,
    }
  })

  nvim_lsp.rust_analyzer.setup(coq().lsp_ensure_capabilities{
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern { '.git/' },
    flags = {
      debounce_text_changes = 150,
    }
  })

  nvim_lsp.elixirls.setup(coq().lsp_ensure_capabilities{
    cmd = { "/Users/gabriel/.elixir-ls/language_server.sh" },
    root_dir = nvim_lsp.util.root_pattern { '.git/', 'mix.exs' },
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  })


  local prettier = {
    formatCommand = 'npx prettierd "${INPUT}"',
    formatStdin = true,
    env = {
      string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand('~/.config/nvim/utils/linter-config/.prettierrc.json')),
    },
  }

  local languages = {
    css = { prettier },
    html = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
    json = { prettier },
    markdown = { prettier },
    scss = { prettier },
    scss = { prettier },
    typescript = { prettier },
    solidity = { prettier },
    typescriptreact = { prettier },
    yaml = { prettier }
  }

  nvim_lsp.efm.setup(coq().lsp_ensure_capabilities {
    on_attach = on_attach,
    init_options = { documentFormatting = true, codeAction = true },
    root_dir = nvim_lsp.util.root_pattern { '.git/', '.' },
    filetypes = vim.tbl_keys(languages),
    settings = { languages = languages }
  })

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
  })
end)
