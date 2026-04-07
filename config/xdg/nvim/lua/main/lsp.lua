vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
})

require("mason").setup({})

vim.diagnostic.config({
	float = {
		style = "minimal",
		header = "",
	},
})

vim.lsp.config("*", {
	on_attach = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set('n', "<leader>fmt", vim.lsp.buf.format)
		vim.keymap.set('n', "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set('n', "<leader>vrf", vim.lsp.buf.references, opts)
		vim.keymap.set('n', "<leader>vrn", vim.lsp.buf.rename, opts)
		vim.keymap.set('n', "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set('n', "gd", vim.lsp.buf.definition, opts)
	end,
})

do
	local function ls(path)
		local o = {}
		vim.system({ "ls", "-1", path }, { text = true }, function(i)
			for s in string.gmatch(i.stdout, "([^" .. '\n' .. "]+)") do
				table.insert(o, s)
			end
		end):wait()
		return o
	end
	for _, i in ipairs(ls(vim.fn.stdpath("config") .. "/lsp")) do
		vim.lsp.enable(i:sub(1, -5))
	end
end

do
	local cmp = require("cmp")
	local snip = require('luasnip')

	cmp.setup({
		snippet = {
			expand = function(args)
				snip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<C-Space>'] = cmp.mapping.complete(),
			['<Tab>'] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = 'luasnip' },
		})
	})
end
