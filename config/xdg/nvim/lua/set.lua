require("vim._core.ui2").enable({})

vim.cmd.packadd("nvim.undotree")


vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineGap", { bg = "black" })

vim.cmd.aunmenu("PopUp.-1-")
vim.cmd.aunmenu("PopUp.-2-")
vim.cmd.aunmenu("PopUp.How-to\\ disable\\ mouse")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = "tab:> "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.autocomplete = true

vim.opt.smartindent = true

vim.opt.scrolloff = 8

vim.opt.winborder = { '-', '-', '-', '=', '-', '-', '-', '=' }

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1

vim.opt.showmode = false
vim.opt.statusline =
		" " ..
		"%{&readonly?'-':(&modified?'+':'=')}"
		.. " {%{mode()}}"
		.. " [%{expand('%:~:.')}]"
		.. " %#StatusLineGap#%=%* " ..
		"<%l,%c> " ..
		"(%{&fileformat}|%{&fileencoding}|%{&filetype})"
		.. " "

vim.opt.shortmess = "lmrwoOstTAIcCFS"

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	callback = function()
		vim.wo.fillchars = "eob: "
	end
})

vim.api.nvim_create_autocmd("FileChangedRO", {
	callback = function()
		vim.opt.readonly = false
		print("- > =")
	end
})

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
