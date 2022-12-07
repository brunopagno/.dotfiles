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

vim.opt.mouse = "c"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true

-- telescope config
require("telescope").setup{ defaults = { file_ignore_patterns = { "node_modules" } } }

