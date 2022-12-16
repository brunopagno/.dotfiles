require("nvim-treesitter.configs").setup({
  ensure_installed = { "javascript", "typescript", "lua", "ruby" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
