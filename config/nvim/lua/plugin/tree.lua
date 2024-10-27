return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		vim.cmd.Ex = vim.cmd["NvimTreeToggle"]

		local dir = { '>', '=' }
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
							default = dir[1],
							open = dir[2],
							empty = dir[1],
							empty_open = dir[2],
							symlink = dir[1],
							symlink_open = dir[2],
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
