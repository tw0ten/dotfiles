vim.pack.add({
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
	"https://github.com/mbbill/undotree",
})

require("mini.pick").setup({
	window = {
		prompt_prefix = '',
	},
})
