vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

vim.opt.showmode = false
vim.opt.statusline=" %{&readonly?'-':(&modified?'+':'=')} {%{mode()}} %f %#Normal#%=%* <%l,%c> (%{&fileformat}|%{&fileencoding}|%Y) "
vim.opt.laststatus=2
