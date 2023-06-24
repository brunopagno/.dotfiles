-- LSP
local lspconfig = require('lspconfig')

-- null ls
local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
    formatting.prettier,
}

null_ls.setup({
    sources = sources,
})

-- Setup servers

-- npm i -g typescript typescript-language-server prettier
lspconfig.tsserver.setup({})
