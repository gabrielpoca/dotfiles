return {
  {
    "stevearc/conform.nvim",
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      formatters_by_ft = {
        jinja = { "djlint" },
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        svelte = { { "prettierd", "prettier" } },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
}
