-- setup lazy.nvim
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


require('lazy').setup({
  { 'jiangmiao/auto-pairs' },
  -- coment
  { 'numToStr/Comment.nvim' },
  --terminal
  { "akinsho/toggleterm.nvim" },
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  'nvim-lualine/lualine.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      -- comment for jsx,tsx
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  -- lsp
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  -- autocomplete
  "hrsh7th/nvim-cmp",
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  -- snippet
  'saadparwaiz1/cmp_luasnip',
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    dependencies = { "rafamadriz/friendly-snippets",lazy=true },
  },
  -- "L3MON4D3/LuaSnip",
  -- "rafamadriz/friendly-snippets",
  -- formatting and linting
  "jose-elias-alvarez/null-ls.nvim",
  -- git
  "tpope/vim-fugitive",
  --file explorer
  "kyazdani42/nvim-web-devicons",
  'nvim-tree/nvim-tree.lua',
  -- colour scheme
  'folke/tokyonight.nvim',
  { "catppuccin/nvim", name = "catppuccin" },
  -- auto tag close
  'windwp/nvim-ts-autotag',
  -- rest nvim for api testing
  'rest-nvim/rest.nvim',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  -- session manager
  {
    'stevearc/resession.nvim',
    opts = {},
  },
  -- harpoon
  "ThePrimeagen/harpoon",

  -- live-server for html and css
  -- "turbio/bracey.vim"

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },

})
-- vim.cmd [[colorscheme tokyonight]] -- set colorscheme to tokyonight
