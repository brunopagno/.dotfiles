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
-- set("n", "<leader>e", "<cmd>Oil<cr>")
set("n", "<leader>e", "<cmd>Ex<cr>")
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

-- AI
set("i", "<c-o>", "<Plug>(copilot-suggest)")
set("n", "<leader>a", "<cmd>CodeCompanionChat<cr>")

-- tabline
vim.o.tabline = "%!v:lua.CustomTabLine()"
function _G.CustomTabLine()
	local s = ""
	local sep = "│"
	local tab_count = vim.fn.tabpagenr("$")
	for i = 1, vim.fn.tabpagenr("$") do
		local winnr = vim.fn.tabpagewinnr(i)
		local buflist = vim.fn.tabpagebuflist(i)
		local bufnr = buflist[winnr]
		local name = vim.fn.bufname(bufnr)
		local fname = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
		local modified = vim.fn.getbufvar(bufnr, "&modified") == 1 and "+ " or ""
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end
		s = s .. " " .. modified .. fname .. " "
		if tab_count > 1 and i < tab_count then
			s = s .. sep
		end
	end
	s = s .. "%#TabLineFill#"
	return s
end

require("gatoguild.lsp")
require("gatoguild.plugins")

vim.cmd([[colorscheme default]])
