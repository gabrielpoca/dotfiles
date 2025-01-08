return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        djlint = {
          command = "djlint",
          args = {
            "--reformat",
            "--format-js",
            "--format-css",
            "-",
          },
          to_stdin = true,
        },
      },
      format_on_save = {
        timeout_ms = 1000,
      },
      formatters_by_ft = {
        jinja = { "djlint" },
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "djlint",
      })
    end,
  },
}
