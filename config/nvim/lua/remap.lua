local function unmap(mode, key)
	vim.keymap.set(mode, key, function() end)
end

unmap('n', "K")
unmap('n', "<C-r>")

vim.keymap.set('n', "r", vim.cmd.redo)

vim.keymap.set('n', "<leader>ex", vim.cmd.Ex)
vim.keymap.set('n', "<leader>wx", function()
	vim.cmd.w()
	vim.cmd.Ex()
end)
vim.keymap.set('n', "<leader>cd", function()
	vim.cmd.cd([[%:p:h]])
	print(vim.fn.getcwd())
end)

vim.keymap.set('n', "<C-_>", function()
	vim.cmd.let([[@/ = '']])
	print("@/ = ''")
end)

vim.keymap.set('n', "<leader>fmt", vim.lsp.buf.format)
vim.keymap.set('n', "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('v', "<C-Down>", [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', "<C-Up>", [[:m '<-2<CR>gv=gv]])

vim.keymap.set('v', "<C-c>", [["+y]])
