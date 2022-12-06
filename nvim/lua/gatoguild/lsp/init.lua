local ok, _ = pcall(require, "lspconfig")
if not ok then
    print("Could not load lspconfig")
    return
end

local opts = { buffer = true, silent = true }
local base = {
    on_attach = function()
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<c-I>", function() vim.lsp.buf.format { async = true }; end,  opts)
    end
}

require("gatoguild.lsp.gopls").setup(base)

require("gatoguild.lsp.solargraph").setup(base)

