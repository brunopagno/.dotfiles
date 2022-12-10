local opts = { noremap = true, silent = true }

function set(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- leader key is space
vim.g.mapleader = " "

set("n", "<leader>e", "<cmd>Explore<cr>")
set("n", "<leader>sv", "<cmd>vsplit<cr>")
set("n", "<leader>sh", "<cmd>split<cr>")
set("n", "<c-k>", "<cmd>wincmd k<cr>")
set("n", "<c-j>", "<cmd>wincmd j<cr>")
set("n", "<c-h>", "<cmd>wincmd h<cr>")
set("n", "<c-l>", "<cmd>wincmd l<cr>")

-- terminal
set({ "n", "t" }, "<c-t>", "<cmd>FloatermToggle<cr>")
set("t", "<esc>", "<c-\\><c-n>")

-- Telescope keys
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")

-- Prettier
set("n", "<leader>fp", "<cmd>Prettier<cr>")
