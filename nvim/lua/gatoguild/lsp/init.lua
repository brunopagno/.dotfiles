local ok, _ = pcall(require, "lspconfig")
if not ok then
  print("Could not load lspconfig")
  return
end


local on_attach = function(client, bufnr)
  print "attached"
end

require("gatoguild.lsp.gopls").setup(on_attach)
