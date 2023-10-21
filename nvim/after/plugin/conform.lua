require("conform").setup({
  formatters_by_ft = {
    ruby = { "rubocop" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true
  }
})
