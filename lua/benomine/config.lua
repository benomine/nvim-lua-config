vim.o.smarttab = true
vim.o.mouse = "a"
vim.o.encoding = "utf-8"
vim.o.showmatch = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.bo.autoindent = true
vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.smartindent = true
vim.bo.fileencoding = "utf-8"
vim.bo.syntax = "enable"

vim.o.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

vim.g.OmniSharp_server_path = mason_path .. "/bin/omnisharp"
vim.o.background = 'dark'

--vim.cmd('colorscheme nightfox')
--vim.cmd("colorscheme tokyonight")

vim.cmd("colorscheme darkplus")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.fillchars.eob = " "
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

vim.diagnostic.config({
	virtual_text = false,
	virtual_line = true,
})
