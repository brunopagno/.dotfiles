local ok, _ = pcall(require, "lspconfig")
if not ok then
  print("Could not load lspconfig")
  return
end

on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
end

require("lspconfig")["tsserver"].setup({
  on_attach = on_attach
})

