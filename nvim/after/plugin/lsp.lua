-- LSP
local lspconfig = require('lspconfig')

-- null ls
local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local sources = {
    formatting.prettier,
    formatting.rubocop,
    formatting.rustfmt,
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
lspconfig.tsserver.setup({
    init_options = {
        preferences = {
            disableSuggestions = true,
        }
    }
})

-- npm i -g @volar/vue-language-server
-- lspconfig.volar.setup({
--     filetypes = {
--         'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'
--     },
-- })

-- rustup component add rust-analyzer
lspconfig.rust_analyzer.setup({
    cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
})
