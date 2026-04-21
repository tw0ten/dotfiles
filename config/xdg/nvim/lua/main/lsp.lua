vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if kind == 'install' or kind == 'update' then
			if name == 'nvim-lspconfig' then
				vim.system({ "ln", "-sf",
					vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-lspconfig/lsp/",
					vim.fn.stdpath("config")
				})
			end
		end
	end
})

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

do
	local o = {}
	vim.system({ "ls", "-1", vim.fn.stdpath("config") .. "/lsp" }, { text = true }, function(i)
		for s in string.gmatch(i.stdout, "([^" .. '\n' .. "]+)") do
			table.insert(o, s:sub(1, -5))
		end
	end):wait()
	vim.lsp.enable(o)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function() vim.cmd.lsp("enable") end,
	})
end

require("mini.completion").setup({})
