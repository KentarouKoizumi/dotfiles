vim.opt["clipboard"] = "unnamedplus"
vim.opt.timeoutlen = 300

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  space = "·",
  trail = "•",
  nbsp = "␣",
}

vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.inccommand = "split"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
