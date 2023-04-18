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

-- lua-language-server
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

-- npm i -g typescript typescript-language-server prettier
lspconfig.tsserver.setup({})
