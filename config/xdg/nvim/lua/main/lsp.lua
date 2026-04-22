vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.completion",
})

do
	local ts = require("nvim-treesitter")
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ts.get_available(),
		callback = function(ev)
			ts.install({ ev.match }):wait()
			vim.treesitter.start()
		end,
	})
end

require("mason").setup({})

vim.api.nvim_create_autocmd("FileType", {
	callback = function() vim.cmd.lsp("enable") end,
})

require("mini.completion").setup({})
