-- LSP
local lspconfig = require('lspconfig')

-- NullLS
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
    formatting.prettier,
    formatting.rubocop,
    formatting.rustfmt,
    diagnostics.rubocop,
}

null_ls.setup({
    sources = sources,
})

-- Setup servers

-- gem install solargraph
lspconfig.solargraph.setup({})

-- brew install lua-language-server
-- apt install lua-language-server # double check if this works
lspconfig.sumneko_lua.setup({})

-- npm i -g typescript typescript-language-server
-- npm i -g prettier
lspconfig.tsserver.setup({})

-- rustup component add rust-analyzer
-- rustup component add rustfmt
lspconfig.rust_analyzer.setup({
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
})
