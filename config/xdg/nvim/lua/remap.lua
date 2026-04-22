vim.g.mapleader = ' '


vim.keymap.set('n', "<leader>U", function()
	vim.pack.update()
end)

vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set('n', "<leader>w", vim.cmd.w)

vim.keymap.set('n', "<leader>cd", function()
	vim.cmd.cd([[%:p:h]])
	print(vim.fn.getcwd())
end)

vim.keymap.set('n', "<leader>ex", vim.cmd.NvimTreeToggle)

vim.keymap.set('n', "<C-/>", function()
	vim.cmd.let([[@/ = '']])
	print("@/ = ''")
end)

vim.keymap.set('n', "U", vim.cmd.redo)

vim.keymap.set('v', "<C-Down>", [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', "<C-Up>", [[:m '<-2<CR>gv=gv]])

vim.keymap.set('v', "<C-c>", [["+y]])

vim.keymap.set('n', "fmt", vim.lsp.buf.format)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local o = { buffer = ev.buf }
		vim.keymap.set('n', "vca", vim.lsp.buf.code_action, o)
		vim.keymap.set('n', "vd", vim.diagnostic.open_float, o)
		vim.keymap.set('n', "vgd", vim.lsp.buf.definition, o)
		vim.keymap.set('n', "vrf", vim.lsp.buf.references, o)
		vim.keymap.set('n', "vrn", vim.lsp.buf.rename, o)
		vim.keymap.set('n', "vws", vim.lsp.buf.workspace_symbol, o)
	end,
})
