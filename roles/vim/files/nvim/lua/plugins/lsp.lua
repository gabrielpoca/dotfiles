return {
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      create_autocmd = false,
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false,
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    keys = {
      { "<C-LeftMouse>", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Jump to type definition" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      {
        "<leader>ld",
        "<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<cr>",
        "Diagnostics",
      },
      {
        "<leader>lD",
        "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
        "Workspace Diagnostics",
      },
      { "<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Symbols" },
      {
        "<leader>lS",
        "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
        "Workspace Symbols",
      },
      { "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
      {
        "<leader>lK",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        "Jump to type definition",
      },
      { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>", "Line Diagnostics" },
      { "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      {
        "<leader>lwa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
        "Add Workspace Folder",
      },
      {
        "<leader>lwl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
        "List Workspace Folders",
      },
      {
        "<leader>lwr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
        "Remove Workspace Folder",
      },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
      { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" },
      { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
      { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
      { "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })

      local nvim_lsp = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local on_attach = function(client, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
      end

      local do_setup = function(name, config)
        nvim_lsp[name].setup(merge({
          capabilities = capabilities,
          on_attach = on_attach,
          flags = { debounce_text_changes = 150 },
          root_dir = nvim_lsp.util.root_pattern({ ".git" }),
        }, config))
      end

      nvim_lsp.lua_ls.setup({
        settings = { Lua = { completion = { callSnippet = "Replace" } } },
      })

      do_setup("rust_analyzer", {
        root_dir = nvim_lsp.util.root_pattern({ "Cargo.toml" }),
        settings = {
          ["rust-analyzer"] = {
            ["checkOnSave"] = { ["enabled"] = true, ["command"] = "clippy" },
          },
        },
      })

      local function tsserver_root_dir()
        local tsconfigroot = nvim_lsp.util.root_pattern("tsconfig.json")
        local denoroot = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")

        return function(startpath)
          -- don't start tsserver if deno is in there
          if denoroot(startpath) then
            return
          else
            return tsconfigroot(startpath)
          end
        end
      end

      do_setup("tsserver", { root_dir = tsserver_root_dir(), single_file_support = false })

      do_setup("solc", { root_dir = nvim_lsp.util.root_pattern({ "hardhat.config.ts" }) })

      do_setup("elixirls", { root_dir = nvim_lsp.util.root_pattern({ "mix.exs" }) })

      do_setup("svelte", { root_dir = nvim_lsp.util.root_pattern({ "svelte.config.js" }) })

      do_setup("svelte", { root_dir = nvim_lsp.util.root_pattern({ "svelte.config.js" }) })

      do_setup("volar", { root_dir = nvim_lsp.util.root_pattern({ "vite.config.ts" }) })

      do_setup("tailwindcss", {
        root_dir = nvim_lsp.util.root_pattern({
          "tailwind.config.js",
          "tailwind.config.cjs",
        }),
      })

      do_setup("eslint", { root_dir = nvim_lsp.util.root_pattern({ "package.json" }) })

      vim.diagnostic.config({
        virtual_text = true,
        signs = false,
        float = { border = "single" },
        update_in_insert = false,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    end,
  },
}
