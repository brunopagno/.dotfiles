-- LSP
local lspconfig = require('lspconfig')

-- null ls
local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
    formatting.prettier,

    formatting.rubocop,
    diagnostics.rubocop,
}

null_ls.setup({
    sources = sources,
})

-- Setup servers

-- gem install solargraph
lspconfig.solargraph.setup({})

-- npm i -g typescript typescript-language-server prettier
lspconfig.tsserver.setup({})

-- go get golang.org/x/tools/gopls@latest
-- export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
lspconfig.gopls.setup({})
