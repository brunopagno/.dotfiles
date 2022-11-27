require('plugins')

local set = vim.opt

-- general
set.number = true
set.scrolloff = 12
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = true
set.clipboard = 'unnamed'
set.ruler = true
set.relativenumber = true
vim.g.mapleader = ' '

-- theme
vim.cmd([[
  if has('termguicolors')
    set termguicolors
  endif
  set background=dark
  let g:everforest_background = 'soft'
  let g:everforest_better_performance = 1
  colorscheme everforest
]])

-- shortcuts

-- fuzzy finder
vim.keymap.set("n", "<Leader>p", ":FZF<CR>", {})
-- file explorer
vim.keymap.set("n", "<Leader>e", ":Explore<CR>", {})

-- screen split
vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", {})
vim.keymap.set("n", "<Leader>s", ":split<CR>", {})
-- terminal specific
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})


-- LSP config
require('lsp_config')

