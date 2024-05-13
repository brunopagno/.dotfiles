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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

set("n", "<leader>/", "<cmd>noh<cr>")

-- navigation
set({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
set({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
set({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
set({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")
set("n", "<leader>vh", "<cmd>vs | wincmd H<cr>")
set("n", "<leader>vj", "<cmd>vs | wincmd J<cr>")
set("n", "<leader>vk", "<cmd>vs | wincmd K<cr>")
set("n", "<leader>vl", "<cmd>vs | wincmd L<cr>")

-- resize
set({ "t", "n" }, "<M-up>", "<cmd>resize +10<cr>")
set({ "t", "n" }, "<M-down>", "<cmd>resize -10<cr>")
set("n", "<M-right>", "<cmd>vertical resize +10<cr>")
set("n", "<M-left>", "<cmd>vertical resize -10<cr>")

-- copy to clipboard
set("v", "<leader>y", '"+y')

-- buffers
set("n", "<leader>q", "<cmd>bd<cr>")
set("n", "<leader>cfp", "<cmd>call setreg('+', expand('%'))<cr>")

-- search and find
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
set("n", "<leader>,", "<cmd>Telescope buffers<cr>")
set("n", "<leader>F", "<cmd>Telescope live_grep<cr>")

-- LSP
-- set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
set("n", "<leader>f", function()
	require("conform").format()
end)
set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

-- file navigation
set("n", "<leader>e", "<cmd>Oil<cr>")

-- console
local function splitterm(direction)
	vim.api.nvim_command("split")
	vim.api.nvim_command("term")
	vim.api.nvim_command("wincmd " .. direction)
end

vim.cmd([[
  autocmd TermOpen,BufEnter,WinEnter term://* startinsert
]])
set("t", "<esc>", "<c-\\><c-n>")
set("n", "<leader>th", function()
	splitterm("H")
end)
set("n", "<leader>tj", function()
	splitterm("J")
end)
set("n", "<leader>tk", function()
	splitterm("K")
end)
set("n", "<leader>tl", function()
	splitterm("L")
end)

-- copiloto
set("i", "<c-o>", "<Plug>(copilot-suggest)")

require("gatoguild.plugins")
