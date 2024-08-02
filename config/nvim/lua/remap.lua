vim.keymap.set("n", "<leader>cd", function()
	vim.cmd.cd("%:h")
	print("cd:"..vim.fn.getcwd())
end)
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>wx", function()
	vim.cmd.w()
	vim.cmd.Ex()
end)

--       todo: allow <C-/> in st?
vim.keymap.set("n", "<C-_>", function() vim.cmd.let("@/ = ''") end)

vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<C-c>", '"+y')
