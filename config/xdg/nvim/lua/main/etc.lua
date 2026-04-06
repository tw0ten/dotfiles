vim.pack.add({
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
})

do
	local pick = require("mini.pick")
	pick.setup({})

	vim.keymap.set('n', "<leader>ff", pick.builtin.files)
	vim.keymap.set('n', "<leader>fw", pick.builtin.grep_live)
end

do
	require("rainbow-delimiters.setup").setup({})
	vim.api.nvim_set_hl(0, "Normal", { bg = nil })
end
