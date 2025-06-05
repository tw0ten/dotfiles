return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = require("rainbow-delimiters").strategy["global"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterGreen",
					"RainbowDelimiterBlue",
					"RainbowDelimiterViolet",
				},
			})
		end
	},
	{
		"tomasiser/vim-code-dark",
		config = function()
			vim.cmd(":colorscheme codedark")
			vim.api.nvim_set_hl(0, "Normal", { bg = "" })
		end
	},
}
