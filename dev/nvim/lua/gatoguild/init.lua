-- Options

vim.opt.number = true
vim.opt.relativenumber = true
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

set("n", "<leader>ss", "<cmd>split<cr>")
set("n", "<leader>vs", "<cmd>vsplit<cr>")
set("n", "<leader>/", "<cmd>noh<cr>")
set("n", "<leader>z", "<cmd>set wrap!<cr>")

-- navigation
set({ "n", "t" }, "<C-up>", "<cmd>wincmd k<cr>")
set({ "n", "t" }, "<C-down>", "<cmd>wincmd j<cr>")
set({ "n", "t" }, "<C-left>", "<cmd>wincmd h<cr>")
set({ "n", "t" }, "<C-right>", "<cmd>wincmd l<cr>")

-- resize
set({ "t", "n" }, "<M-up>", "<cmd>resize +10<cr>")
set({ "t", "n" }, "<M-down>", "<cmd>resize -10<cr>")
set("n", "<M-right>", "<cmd>vertical resize +10<cr>")
set("n", "<M-left>", "<cmd>vertical resize -10<cr>")

-- copy to clipboard
set("v", "<leader>y", '"+y')

-- move lines
set("n", "<s-up>", "<cmd>m-2<cr>")
set("n", "<s-down>", "<cmd>m+<cr>")

-- search and find
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
set("n", "<leader>F", "<cmd>Telescope live_grep<cr>")

-- LSP
set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "<f4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

-- file navigation
set("n", "<leader>er", "<cmd>Vexplore!<cr>")
set("n", "<leader>ew", "<cmd>Vexplore<cr>")
set("n", "<leader>ee", "<cmd>Explore<cr>")

vim.g.netrw_preview = 1

-- console
set("n", "<leader>tt", "<cmd>term<cr>")
set("t", "<esc>", "<c-\\><c-n>")
vim.cmd([[
  autocmd TermOpen,BufEnter,WinEnter term://* startinsert
]])

-- commands
-- function GatoNewBuffer(cmd)
--   vim.cmd("vs")
--   vim.cmd("wincmd l")
--   local vim_cmd = string.format("enew | put=execute('%s')", cmd)
--   print(vim_cmd)
--   vim.cmd(vim_cmd)
-- end
-- 
-- function GatoFind(options)
--   local key = options.args
--   GatoNewBuffer(string.format("find ./ -name \"%s\"", key))
-- end
-- 
-- vim.api.nvim_create_user_command('GatoFind', GatoFind, { nargs = 1 })

require("gatoguild.plugins")
