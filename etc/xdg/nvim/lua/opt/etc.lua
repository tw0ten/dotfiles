vim.pack.add({
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/echasnovski/mini.notify",
})

require("mini.pick").setup({
	window = {
		prompt_prefix = '',
	},
})

require("mini.notify").setup({})


vim.filetype.add({
	extension = {
		["k"] = "komptal",
	},
})
