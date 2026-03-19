return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup({})

			vim.api.nvim_set_hl(0, "Normal", { bg = nil })
		end
	},
}
