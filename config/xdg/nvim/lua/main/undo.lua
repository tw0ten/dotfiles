vim.pack.add({
	"https://github.com/mbbill/undotree",
})

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)
