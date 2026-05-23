vim.g.mapleader = ' '

vim.keymap.set('n', "<leader>U", function()
	vim.pack.update()
end, { desc = "update" })

vim.keymap.set('n', "<leader>u", vim.cmd.Undotree, { desc = ":Undotree" })

vim.keymap.set('n', "<leader>w", vim.cmd.write, { desc = ":write" })

vim.keymap.set('n', "<leader>cd", function()
	vim.cmd.cd("%:p:h")
	print(vim.fn.getcwd())
end, { desc = "cd ." })

vim.keymap.set('n', "<leader>ex", vim.cmd.NvimTreeToggle, { desc = ":NvimTreeToggle" })

vim.keymap.set('n', "<C-/>", function() vim.cmd.let("@/ = ''") end, { desc = ":let @l = ''" })

vim.keymap.set('n', "U", vim.cmd.redo)
vim.keymap.set('n', "<C-r>", function() end)

vim.keymap.set('v', "<C-c>", "\"+y", { desc = "copy" })

vim.keymap.set('n', "todo", function()
	vim.cmd.normal("o")
	vim.cmd.normal("0D")
	vim.cmd.normal("itodo")
	vim.cmd.normal("gcc")
	vim.cmd("s/todo/#todo /")
	vim.cmd.normal("==")
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("A", true, false, true), "n", false)
end, { desc = "todo" })

vim.keymap.set('n', "fmt", vim.lsp.buf.format)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local o = { buffer = ev.buf }
		vim.keymap.set('n', "vca", vim.lsp.buf.code_action, o)
		vim.keymap.set('n', "vd", vim.diagnostic.open_float, o)
		vim.keymap.set('n', "vgd", vim.lsp.buf.definition, o)
		vim.keymap.set('n', "vrf", vim.lsp.buf.references, o)
		vim.keymap.set('n', "vrn", vim.lsp.buf.rename, o)
		vim.keymap.set('n', "vs", vim.lsp.buf.workspace_symbol, o)
	end,
})

vim.keymap.set('n', "<leader>ff", function() vim.cmd.Pick("files") end, { desc = ":Pick files" })
vim.keymap.set('n', "<leader>fw", function() vim.cmd.Pick("grep_live") end, { desc = ":Pick grep_live" })
