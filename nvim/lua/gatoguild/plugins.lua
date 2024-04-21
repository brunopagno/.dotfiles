local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- general dependencies
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc" },
      highlight = {
        enable = true
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- ui and theme
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    priority = 1000,
    config = function()
      vim.cmd([[
        colorscheme nightfox
      ]])
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│"
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
    end,
  },

  -- finder and search
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local actions = require "telescope.actions"
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules/.*", ".git/.*" },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          buffers = {
            mappings = {
              i = {
                ["<c-x>"] = actions.delete_buffer
              },
            },
          }
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.tsserver.setup({})
      lspconfig.solargraph.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      lspconfig.gopls.setup({})
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          ruby = { "rubocop" },
          go = { "goimports", "gofmt" },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- autocompletions
  { "L3MON4D3/LuaSnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-space>"] = cmp.mapping.complete(),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources(
          {
            { name = "nvim_lsp" },
            { name = "path" },
          }, {
            { name = "buffer" },
          }),
      })
    end,
  },

  -- git
  { "tpope/vim-fugitive" },
})
