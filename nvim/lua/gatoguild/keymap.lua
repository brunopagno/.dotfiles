local opts = { noremap = true, silent = true }

function set(mode, lhs, rhs)
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

-- move lines
set("n", "<s-up>", "<cmd>m-2<cr>")
set("n", "<s-down>", "<cmd>m+<cr>")

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

-- DAP
-- set("n", "<f5>", "<cmd>lua require'dap'.continue()<cr>")
-- set("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>")
-- set("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>")
-- set("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>")
-- set("n", "<Leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
-- set("n", "<Leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
-- set("n", "<Leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
-- set("n", "<Leader>dr", "<cmd>lua require'dap'.repl.open()<cr>")
-- set("n", "<Leader>dl", "<cmd>lua require'dap'.run_last()<cr>")

