local null_ls = require("null-ls")

null_ls.setup({
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.diagnostics.rubocop,
})
