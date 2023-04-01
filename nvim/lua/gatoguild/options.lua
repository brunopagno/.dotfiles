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

vim.cmd("packadd termdebug")
vim.g.termdebug_wide = 1
