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

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.org",
  callback = function()
    vim.opt.swapfile = false
  end,
})

-- Patch archived nvim-treesitter query handlers for the Neovim 0.12 match API.
-- nvim-treesitter registers them on load, so re-apply our shim afterwards (or
-- now, if it is already loaded).
if package.loaded["nvim-treesitter"] then
  require "utils.treesitter_compat"
else
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(args)
      if args.data == "nvim-treesitter" then
        require "utils.treesitter_compat"
        return true
      end
    end,
  })
end
