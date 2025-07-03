return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)
		vim.opt.swapfile = false
		vim.opt.backup = false
		vim.opt.undofile = true
		vim.opt.undodir = vim.fn.stdpath("data") .. "/undotree"
	end
}
