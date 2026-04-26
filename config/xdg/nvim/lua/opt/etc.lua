vim.pack.add({
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
})

require("mini.pick").setup({
	window = {
		prompt_prefix = '',
	},
})

vim.cmd.packadd("nvim.undotree")
