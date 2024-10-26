return {
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
						symlink = '<',
						folder = {
							arrow_open = '',
							arrow_closed = '',
							default = '>',
							open = '>',
							empty = '>',
							empty_open = '>',
							symlink = '>',
							symlink_open = '>',
						},
						git = {
							unstaged = '*',
							staged = '',
							unmerged = '',
							renamed = '',
							untracked = '',
							deleted = '',
							ignored = '',
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
				git_ignored = false,
			},
		})
	end
}
