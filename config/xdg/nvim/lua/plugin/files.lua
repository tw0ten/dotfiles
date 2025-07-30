return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.cmd.Ex = vim.cmd["NvimTreeToggle"]

			require("nvim-tree").setup({
				disable_netrw = true,
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
				view = {
					width = 30,
					side = "left",
					signcolumn = "no",
				},
				sort = {
					sorter = "case_sensitive",
				},
				filters = {
					git_ignored = true,
					dotfiles = true,
				},
			})
		end
	},
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({})
		end
	}
}
