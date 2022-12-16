require("telescope").setup{ defaults = { file_ignore_patterns = { "node_modules" } } }

vim.keymap.set("n", "<leader>tp", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
