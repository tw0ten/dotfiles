return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim"
	},
	config = function()
		require('telescope').setup({})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fw', function()
			builtin.grep_string({ search = vim.fn.input("fw: ") })
		end)
	end
}
