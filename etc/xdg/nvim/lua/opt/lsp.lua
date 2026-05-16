vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/nvim-mini/mini.completion" },
})

do
	local ts = require("nvim-treesitter")
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ts.get_available(),
		callback = function(ev)
			ts.install({ ev.match }):wait()
			vim.treesitter.start(ev.buf)
		end,
	})
end

require("mason").setup({})

require("mini.completion").setup({})


vim.api.nvim_create_autocmd("FileType", {
	callback = function() vim.cmd.lsp("enable") end,
})
