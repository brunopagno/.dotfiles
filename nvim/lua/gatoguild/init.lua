-- Options

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ruler = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.mouse = "nv"
vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.swapfile = false

-- Keymap
local opts = { noremap = true, silent = true }

local function set(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

set("n", "<leader>/", "<cmd>noh<cr>")

-- copy to clipboard
set("v", "<leader>y", '"+y')

-- navigation
set("n", "<C-k>", "<cmd>wincmd k<cr>")
set("n", "<C-j>", "<cmd>wincmd j<cr>")
set("n", "<C-l>", "<cmd>wincmd l<cr>")
set("n", "<C-h>", "<cmd>wincmd h<cr>")
set("n", "<leader>vs", "<cmd>vsplit<cr>")
set("n", "<leader>ss", "<cmd>split<cr>")
set("n", "<leader>tt", "<cmd>wincmd T<cr>")
set("n", "<leader>tc", "<cmd>tabc<cr>")
set("n", "<C-M-l>", "<cmd>tabn<cr>")
set("n", "<C-M-h>", "<cmd>tabp<cr>")
set("n", "<leader>z", function()
	if vim.g.is_zoomed_in then
		vim.g.is_zoomed_in = false
		vim.cmd("wincmd =")
	else
		vim.g.is_zoomed_in = true
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
		vim.cmd("normal! zH")
	end
end)

-- buffers
set("n", "<leader>q", "<cmd>bd<cr>")
set("n", "<leader>cfp", "<cmd>call setreg('+', expand('%:.'))<cr>")

-- search and find
set("n", "<leader>p", "<cmd>FzfLua files<cr>")
set("n", "<leader>,", "<cmd>FzfLua buffers<cr>")
set("n", "<leader>F", "<cmd>FzfLua live_grep<cr>")

-- for when I have some patience
-- https://neovim.io/doc/user/tabpage.html#_4.-setting-'tabline'
-- customize the tabline

require("gatoguild.plugins")
