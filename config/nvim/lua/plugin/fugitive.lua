return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set('n', "<leader>git", vim.cmd.Git)
	end
}
