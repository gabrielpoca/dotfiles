return {
  "numToStr/Navigator.nvim",
  opts = {
    disable_on_zoom = false,
  },
  keys = {
    { "<C-h>", function() require("Navigator").left() end },
    { "<C-l>", function() require("Navigator").right() end },
    { "<C-k>", function() require("Navigator").up() end },
    { "<C-j>", function() require("Navigator").down() end },
  },
}
