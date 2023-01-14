-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer manager
  use 'wbthomason/packer.nvim'

  -- telescope

use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use 'nvim-lualine/lualine.nvim'

use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

use "williamboman/mason.nvim" 
use "williamboman/mason-lspconfig.nvim"
use "neovim/nvim-lspconfig"
--use "hrsh7th/nvim-cmp"

use "kyazdani42/nvim-web-devicons"
use 'nvim-tree/nvim-tree.lua'

-- tokyo night colour scheme
use 'folke/tokyonight.nvim'
end)
