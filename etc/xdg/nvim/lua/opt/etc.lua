vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.notify" },
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
