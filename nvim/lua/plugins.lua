
return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  -- Theme
  use('sainnhe/everforest')

  -- Stuff
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate"
  })
  use('junegunn/fzf')
  use('neovim/nvim-lspconfig')
end)

