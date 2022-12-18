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

-- terminal
set({ "n", "t" }, "<c-t>", "<cmd>FloatermToggle<cr>")
set("t", "<esc>", "<c-\\><c-n>")

-- Telescope
vim.keymap.set("n", "<leader>tp", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
