-- https://www.youtube.com/watch?v=87AXw9Quy9U&list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.opt.wrap = false

-- Synchronizes system clipboard with Neovim's clipboard
vim.opt.clipboard = "unnamedplus"

-- vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

-- Splits screen on %s 
-- vim.opt.inccommand = "split"

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


-- Trying to fix annoying shifting when changing edit modes
vim.opt.signcolumn = "yes"
