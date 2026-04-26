vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",
})

require("oil").setup({})

require("nvim-tree").setup({
	renderer = {
		root_folder_modifier = ":~:s?$?/",
		indent_width = 1,
		symlink_destination = false,
		icons = {
			show = {
				folder_arrow = false,
			},
			glyphs = {
				default = '-',
				symlink = '@',
				git = {
					unstaged = '*',
					staged = '',
					unmerged = '',
					renamed = '',
					untracked = '',
					deleted = '',
					ignored = '',
				},
				folder = {
					default = '>',
					open = '-',
					empty = ' ',
					empty_open = '-',
					symlink = '<',
					symlink_open = '-',
				},
			},
		},
	},
	filters = {
		dotfiles = true,
	},
})
