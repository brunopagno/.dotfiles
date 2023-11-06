-- Options

-- :help options
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
vim.opt.mouse = "c"
vim.opt.backup = false
vim.opt.swapfile = false

-- netrw
vim.g.netrw_preview = 1 -- vertical preview

-- auto format on save
vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")

-- Keymap

local opts = { noremap = true, silent = true }

local function set(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

set("n", "<leader>e", "<cmd>Explore<cr>")
set("n", "<leader>vs", "<cmd>vsplit<cr>")
set("n", "<leader>ss", "<cmd>split<cr>")
set("n", "<up>", "<cmd>wincmd k<cr>")
set("n", "<down>", "<cmd>wincmd j<cr>")
set("n", "<left>", "<cmd>wincmd h<cr>")
set("n", "<right>", "<cmd>wincmd l<cr>")
set("n", "<leader>/", "<cmd>noh<cr>")
set("n", "<leader>z", "<cmd>set wrap!<cr>")

-- copy to clipboard
set("v", "<leader>y", '"+y')

-- move lines
set("n", "<s-up>", "<cmd>m-2<cr>")
set("n", "<s-down>", "<cmd>m+<cr>")

-- buffers
set("n", "<c-b>", "<cmd>ls<cr>")
set("n", "<c-s-right>", "<cmd>bn<cr>")
set("n", "<c-s-left>", "<cmd>bp<cr>")
set("n", "<c-q>", "<cmd>bd<cr>")

-- Telescope
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
set("n", "<leader>F", "<cmd>Telescope live_grep<cr>")

-- LSP
set("n", "<leader>f", "<cmd>Neoformat<cr>")
set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "<f4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

-- Toggleterm
set("n", "<c-t>", "<cmd>ToggleTerm<cr>")
set("t", "<c-t>", "<cmd>ToggleTerm<cr>")

require("gatoguild.plugins")

vim.cmd[[
  if has('termguicolors')
    set termguicolors
  endif

  set background=dark

  let g:everforest_background = 'soft'
  let g:everforest_better_performance = 1

  colorscheme everforest
]]
