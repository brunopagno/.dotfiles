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

-- fuzzy finder
vim.keymap.set("n", "<Leader>p", ":FZF<CR>", {})
-- formatter
vim.keymap.set("n", "<Leader>i", ":Prettier<CR>", {})
-- file explorer
vim.keymap.set("n", "<Leader>e", ":Explore<CR>", {})

