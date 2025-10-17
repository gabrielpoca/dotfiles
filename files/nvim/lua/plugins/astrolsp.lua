---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      filter = function(client)
        if vim.bo.filetype == "javascript" then return client.name == "biome" end
        if vim.bo.filetype == "typescript" then return client.name == "biome" end

        return true
      end,
    },
    servers = {
      "elixirls",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
      elixirls = function(_, opts)
        require("lspconfig")["elixirls"].setup(vim.tbl_extend("keep", {
          cmd = { vim.fn.expand "~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
        }, opts))
      end,
    },
  },
}
