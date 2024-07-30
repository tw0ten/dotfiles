return {
	"HiPhish/rainbow-delimiters.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")
		require("rainbow-delimiters.setup").setup({
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],

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
		vim.api.nvim_set_hl(0, "Normal", { bg = "" })
	end
}
