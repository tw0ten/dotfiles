return {
	"echasnovski/mini.pick",
	config = function()
		require("mini.pick").setup({})
		local builtin = require("mini.pick").builtin
		vim.keymap.set('n', "<leader>ff", function ()
			 builtin.files()
		end)
		vim.keymap.set('n', "<leader>fw", function()
			builtin.grep_live()
		end)
	end
}
