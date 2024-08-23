vim.opt.mouse = ''

vim.g.mapleader = ' '

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.opt.listchars = "tab:> "

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1

vim.opt.showmode = false
vim.opt.statusline =
" %{&readonly?'-':(&modified?'+':'=')} {%{mode()}} [%{expand('%:~:.')}] %#Normal#%=%* <%l,%c> (%{&fileformat}|%{&fileencoding}|%{&filetype}) "
vim.opt.laststatus = 2

vim.opt.shortmess = "lmrwoOstTAIcCFS"

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.wo.fillchars = "eob: "
	end
})
