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
  use("wbthomason/packer.nvim")

  -- Theme
  use("sainnhe/everforest")

  -- All the things
  use("nvim-lua/plenary.nvim") -- lua functions
  use("nvim-telescope/telescope.nvim") -- fuzzy finder
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end
  }) -- better syntax highlighting
  use("neovim/nvim-lspconfig") -- language server protocol
  use("prettier/vim-prettier")

  -- copilot
  use("github/copilot.vim")
  use("voldikss/vim-floaterm")
end)

