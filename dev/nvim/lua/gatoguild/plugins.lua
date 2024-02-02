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
  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-frappe]])
    end,
  },

  -- general setup
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules/.*", ".git/.*" },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "rust", "typescript", "javascript", "lua", "ruby", "html", "vim", "vimdoc" },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')

      -- npm i -g typescript typescript-language-server prettier
      lspconfig.tsserver.setup({})

      -- gem install solargraph
      lspconfig.solargraph.setup({})

      -- asdf plugin add lua-language-server && asdf install lua-language-server latest && asdf global lua-language-server latest
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local none_ls = require("null-ls")

      local formatting = none_ls.builtins.formatting
      local diagnostics = none_ls.builtins.diagnostics

      local sources = {
        formatting.rubocop,
        formatting.prettier,
        diagnostics.rubocop,
      }

      none_ls.setup({
        sources = sources,
      })
    end,
  },

  -- autocomplete
  { "L3MON4D3/LuaSnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
              ['<c-space>'] = cmp.mapping.complete(),
              ['<c-e>'] = cmp.mapping.abort(),
              ['<cr>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'nvim_lsp' },
        }),
      })
    end,
  },

  -- all the rest
  -- { "github/copilot.vim" },
  { "tpope/vim-fugitive" },
})
