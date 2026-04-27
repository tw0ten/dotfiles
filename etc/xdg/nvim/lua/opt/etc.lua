vim.pack.add({
	"https://github.com/echasnovski/mini.pick",
})

require("mini.pick").setup({
	window = {
		prompt_prefix = '',
	},
})


vim.filetype.add({
	extension = {
		["k"] = "komptal"
	}
})
