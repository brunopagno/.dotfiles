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

