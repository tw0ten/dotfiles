return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		require("fidget").setup({})
		require("mason").setup({})
		vim.filetype.add({
			extension = {
				HC = "HolyC",
				HH = "HolyC",
			},
		})
		local on_attach = function(e)
			local opts = { buffer = e.buf }
			vim.keymap.set('n', "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set('n', "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
			vim.keymap.set('n', "<leader>vd", vim.diagnostic.open_float, opts)
			vim.keymap.set('n', "<leader>vca", vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', "<leader>vrf", vim.lsp.buf.references, opts)
			vim.keymap.set('n', "<leader>vrn", vim.lsp.buf.rename, opts)
			vim.keymap.set('n', "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set('n', "[d", vim.diagnostic.goto_prev, opts)
		end
		require("mason-lspconfig").setup({
			ensure_installed = {},
			handlers = {
				function(server)
					require("lspconfig")[server].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			}
		})
		local cmp = require('cmp')
		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<Tab>'] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, {
				{ name = 'buffer' },
			})
		})
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				header = "",
				prefix = "",
			},
		})
	end
}
