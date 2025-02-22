vim.o.scrolloff = 10
vim.o.sidescrolloff = 16

vim.filetype.add {
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
    njk = "jinja",
  },
}

if vim.g.vscode then vim.o.cmdheight = 3 end
-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
