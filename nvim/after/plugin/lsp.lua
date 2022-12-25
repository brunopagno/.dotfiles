-- LSP
local lspconfig = require('lspconfig')

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 
    "solargraph",
    "sumneko_lua",
    "tsserver",
    "vuels",
    "volar",
  }
})

-- NullLS
local null_ls = require("null-ls")

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

lspconfig["solargraph"].setup {}
lspconfig["sumneko_lua"].setup {}
lspconfig["tsserver"].setup {}
lspconfig["vuels"].setup {}
lspconfig["volar"].setup {}

