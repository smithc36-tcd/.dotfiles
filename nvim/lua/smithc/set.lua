vim.opt.guicursor = ""              --Sets the cursor as a block
vim.g.mapleader = " "               --Sets leader key

vim.opt.nu = true                   --Sets number 
vim.opt.relativenumber = true       --Sets relativeNumber 

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true            --Expands a tab into spaces

vim.opt.smartindent = true
vim.opt.wrap = false                --No wrapping

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8               --Require 8 lines above/below cursor while scrolling
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.termguicolors = true

--vim.opt.spell = true

--vim.g.maplocalleader = " "
vim.opt.colorcolumn = "80"          --Sets column 80 as coloured

vim.opt.updatetime = 50
vim.cmd"filetype plugin on"
vim.cmd [[set iskeyword+=-]]
