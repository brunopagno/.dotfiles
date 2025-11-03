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

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>/", "<cmd>noh<cr>")

-- copy to clipboard
map("v", "<leader>y", '"+y')

-- navigation
map("n", "<C-k>", "<cmd>wincmd k<cr>")
map("n", "<C-j>", "<cmd>wincmd j<cr>")
map("n", "<C-l>", "<cmd>wincmd l<cr>")
map("n", "<C-h>", "<cmd>wincmd h<cr>")
map("n", "<leader>vs", "<cmd>vsplit<cr>")
map("n", "<leader>ss", "<cmd>split<cr>")
map("n", "<leader>tt", "<cmd>wincmd T<cr>")
map("n", "<leader>tc", "<cmd>tabc<cr>")
map("n", "<C-M-l>", "<cmd>tabn<cr>")
map("n", "<C-M-h>", "<cmd>tabp<cr>")
map("n", "<leader>z", function()
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
map("n", "<leader>q", "<cmd>bd<cr>")
map("n", "<leader>cfp", "<cmd>call setreg('+', expand('%:.'))<cr>")

-- search and find
map("n", "<leader>p", "<cmd>FzfLua files<cr>")
map("n", "<leader>,", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>F", "<cmd>FzfLua live_grep<cr>")

-- format, LSP and lint
map({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)
-- map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
map("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
map("n", "<leader>o", "<cmd>OrganizeImports<cr>")

-- file navigation
map("n", "<leader>e", "<cmd>Oil<cr>")

-- AI
-- map("i", "<c-o>", "<Plug>(copilot-suggest)")

-- tabline
require("gatoguild.tabline")
require("gatoguild.lsp")
require("gatoguild.plugins")

-- vim.cmd([[colorscheme default]])
