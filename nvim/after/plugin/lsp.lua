local lsp = require("lsp-zero")

lsp.set_preferences({
  suggest_lsp_servers = false,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = "local",
  sign_icons = {
    error = "X",
    warn = "W",
    hint = "H",
    info = "I"
  }
})

lsp.ensure_installed({
  "solargraph",
  "sumneko_lua",
  "tsserver",
  "vuels",
  "volar",
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local bind = vim.keymap.set

  bind("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
end)

lsp.configure("ruby_ls", {
  cmd = { "bundle", "exec", "ruby-lsp" }
})

lsp.setup()
