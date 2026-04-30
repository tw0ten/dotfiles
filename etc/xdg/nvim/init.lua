vim.opt.swapfile = false
vim.opt.undofile = true


require("vim._core.ui2").enable({})

vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")


require("set")

require("opt.files")
require("opt.lsp")
require("opt.etc")

require("remap")
