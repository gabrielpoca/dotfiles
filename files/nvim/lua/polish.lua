vim.o.scrolloff = 10
vim.o.sidescrolloff = 16

vim.opt.undolevels = 50000
vim.opt.undoreload = 200000

vim.filetype.add {
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
    njk = "jinja",
  },
}
