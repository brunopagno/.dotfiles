local opts = { noremap = true, silent = true }

function set(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- leader key is space
vim.g.mapleader = " "

-- set("n", "<leader>e", "<cmd>Lex 25<cr>")
set("n", "<leader>e", "<cmd>Explore<cr>")
set("n", "<leader>sv", "<cmd>vsplit<cr>")
set("n", "<leader>sh", "<cmd>split<cr>")
set({ "t", "n" }, "<c-k>", "<cmd>wincmd k<cr>")
set({ "t", "n" }, "<c-j>", "<cmd>wincmd j<cr>")
set({ "t", "n" }, "<c-h>", "<cmd>wincmd h<cr>")
set({ "t", "n" }, "<c-l>", "<cmd>wincmd l<cr>")
set("n", "<c-I>", "gg<c-v>G=") -- this is overriden when there's an LSP attached
set("n", "<leader>t", "<cmd>split<cr><cmd>terminal<cr>a")

-- terminal
set("t", "<Esc>", "<C-\\><C-n>")

-- Telescope keys
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")

set("n", "<leader>fdsa", function()
    print(vim.inspect(vim.api.nvim_list_runtime_paths()))
end)
