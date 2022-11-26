
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use { 'junegunn/fzf' }
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
  use { 'sainnhe/everforest' }
end)

