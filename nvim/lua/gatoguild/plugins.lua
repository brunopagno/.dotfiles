vim.pack.add({
  -- ui
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/echasnovski/mini.indentscope",

  -- files and search
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",

  -- autocompletions
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/nvim-cmp",

  -- git
  "https://github.com/lewis6991/gitsigns.nvim",
})

local indentscope = require("mini.indentscope")
indentscope.setup({
  draw = { delay = 0, animation = indentscope.gen_animation.none() },
  symbol = "│",
})

require("oil").setup({
  view_options = { show_hidden = true },
  keymaps = { ["<C-h>"] = false, ["<C-l>"] = false },
})

require("fzf-lua").setup({
  winopts = { preview = { layout = "vertical" } },
  file_ignore_patterns = { "vendor" },
  keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
})

local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<c-p>"] = cmp.mapping.select_prev_item(),
    ["<c-n>"] = cmp.mapping.select_next_item(),
    ["<c-space>"] = cmp.mapping.complete(),
    ["<c-y>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
  }),
})
