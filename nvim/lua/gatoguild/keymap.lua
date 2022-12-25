local opts = { noremap = true, silent = true }

function set(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- leader key is space
vim.g.mapleader = " "

set("n", "<leader>e", "<cmd>Explore<cr>")
set("n", "<leader>vs", "<cmd>vsplit<cr>")
set("n", "<leader>ss", "<cmd>split<cr>")
set("n", "<up>", "<cmd>wincmd k<cr>")
set("n", "<down>", "<cmd>wincmd j<cr>")
set("n", "<left>", "<cmd>wincmd h<cr>")
set("n", "<right>", "<cmd>wincmd l<cr>")

-- tabs
set("n", "<leader>tt", "<cmd>tab split<cr>")
set("n", "<leader>tw", "<cmd>tab close<cr>")

-- buffers
set("n", "<c-s-right>", "<cmd>bn<cr>")
set("n", "<c-s-left>", "<cmd>bp<cr>")
set("n", "<c-q>", "<cmd>bd<cr>")

-- terminal
set({ "n", "t" }, "<c-t>", "<cmd>FloatermToggle<cr>")
set("t", "<esc>", "<c-\\><c-n>")

-- Telescope
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
set("n", "<leader>F", "<cmd>Telescope live_grep<cr>")

-- LSP
set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>")
set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "<f4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

