vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if kind == 'install' or kind == 'update' then
			if name == 'LuaSnip' then
				vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
			end
			if name == 'nvim-lspconfig' then
				vim.system({ "ln", "-sf",
					vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-lspconfig/lsp/",
					vim.fn.stdpath("config")
				})
			end
			if name == 'nvim-treesitter' then
				vim.cmd(":TSUpdate")
			end
		end
	end
})

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local o = { buffer = ev.buf }

		vim.keymap.set('n', "fmt", vim.lsp.buf.format)

		vim.keymap.set('n', "vd", vim.diagnostic.open_float, o)
		vim.keymap.set('n', "vca", vim.lsp.buf.code_action, o)
		vim.keymap.set('n', "vrf", vim.lsp.buf.references, o)
		vim.keymap.set('n', "vrn", vim.lsp.buf.rename, o)
		vim.keymap.set('n', "vws", vim.lsp.buf.workspace_symbol, o)
		vim.keymap.set('n', "vgd", vim.lsp.buf.definition, o)
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
	local snip = require("luasnip")

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
