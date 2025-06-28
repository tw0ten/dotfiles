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
		vim.keymap.set('n', "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', "gd", vim.lsp.buf.definition, opts)
	end,
	root_markers = {
		".git",
		".io",
	},
})

local function ls(path)
	local handle = io.popen('ls "' .. path .. '" 2> /dev/null')
	local o = {}
	if handle then
		for i in handle:read("*a"):gmatch("[^\r\n]+") do
			table.insert(o, i)
		end
		handle:close()
	end
	return o
end

for _, i in ipairs(ls(vim.fn.stdpath("config") .. "/lsp")) do
	vim.lsp.enable(i:sub(1, -5))
end
