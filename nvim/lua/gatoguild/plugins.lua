local fn = vim.fn

-- Automatically download and install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })

  -- Theme
  use({ "sainnhe/everforest" })

  -- All the main things
  use({ "nvim-lua/plenary.nvim" }) -- lua functions
  use({ "nvim-telescope/telescope.nvim" }) -- fuzzy finder
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end
  }) -- better syntax highlighting

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })

  -- autocomplete stuff
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/nvim-cmp" })
  use({ "L3MON4D3/LuaSnip" })

  -- format and lint
  use({ "jose-elias-alvarez/null-ls.nvim" })

  -- All the rest
  use({ "github/copilot.vim" })
  -- use({ "Exafunction/codeium.vim" })
  use({ "voldikss/vim-floaterm" })
  use({ "tpope/vim-fugitive" })
end)
