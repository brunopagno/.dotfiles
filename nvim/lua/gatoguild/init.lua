-- Options

vim.opt.number = true
-- vim.opt.relativenumber = true
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

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = " "
vim.g.maplocalleader = " "

set("n", "<leader>/", "<cmd>noh<cr>")

-- copy to clipboard
set("v", "<leader>y", '"+y')

-- navigation
set({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
set({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
set({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
set({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")
set("n", "<leader>vs", "<cmd>vsplit<cr>")
set("n", "<leader>ss", "<cmd>split<cr>")

-- layout
set("n", "<leader>z", function()
	if vim.g.is_zoomed_in then
		vim.cmd("wincmd =")
	else
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
	end
	vim.g.is_zoomed_in = not vim.g.is_zoomed_in
end)

augroup("ZoomedNavigation", { clear = true })
autocmd("WinEnter", {
	group = "ZoomedNavigation",
	callback = function()
		if vim.g.is_zoomed_in then
			vim.cmd("wincmd _")
			vim.cmd("wincmd |")
		end
	end,
})

-- buffers
set("n", "<leader>q", "<cmd>bd<cr>")
set("n", "<leader>cfp", "<cmd>call setreg('+', expand('%'))<cr>")

-- search and find
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
set("n", "<leader>,", "<cmd>Telescope buffers<cr>")
set("n", "<leader>F", "<cmd>Telescope live_grep<cr>")

-- format
set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)

-- LSP
-- set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

-- file navigation
set("n", "<leader>e", "<cmd>Oil<cr>")

require("gatoguild.plugins")
