return require('packer').startup(function(use)
  -- Packer manager
  use 'wbthomason/packer.nvim'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use 'nvim-lualine/lualine.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- lsp
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"

  -- autocomplete
  use "hrsh7th/nvim-cmp"
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  -- snippet
  use "L3MON4D3/LuaSnip"

  --file explorer
  use "kyazdani42/nvim-web-devicons"
  use 'nvim-tree/nvim-tree.lua'

  -- tokyo night colour scheme
  use 'folke/tokyonight.nvim'
end)
