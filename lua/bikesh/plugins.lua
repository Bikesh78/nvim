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
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
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
    dependencies = { "rafamadriz/friendly-snippets", lazy = true },
  },
  -- "L3MON4D3/LuaSnip",
  -- "rafamadriz/friendly-snippets",
  -- formatting and linting
  -- "jose-elias-alvarez/null-ls.nvim",
  "nvimtools/none-ls.nvim",
  -- git
  "tpope/vim-fugitive",
  --file explorer
  -- "kyazdani42/nvim-web-devicons",
  -- 'nvim-tree/nvim-tree.lua',
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            visible = true,
            show_hidden_count = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
        },
        buffers = { follow_current_file = { enable = true } },
      })
    end
  },
  -- colour scheme
  'folke/tokyonight.nvim',
  { "catppuccin/nvim", name = "catppuccin" },
  "neanias/everforest-nvim",
  "morhetz/gruvbox",
  -- auto tag close
  'windwp/nvim-ts-autotag',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  -- session manager
  {
    'stevearc/resession.nvim',
    opts = {},
  },

  -- neovim code navigation
  {
    "ThePrimeagen/harpoon",
    config = function()
      require('harpoon').setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        }
      })
    end
  },
  -- lsp breadcrumbs (shown in lualine winbar)
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {
      lsp = { auto_attach = true }, -- attach to any client with documentSymbolProvider
      highlight = true,
    },
  },
  -- pin enclosing function/class lines to the top of the window
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false, -- `keys` would otherwise delay loading until [c is pressed
    opts = {
      max_lines = 5, -- keep it from taking over the window in deeply nested code
    },
    keys = {
      {
        '[c',
        function()
          if vim.wo.diff then -- keep built-in "previous change" in diff mode
            vim.cmd('normal! ' .. vim.v.count1 .. '[c')
          else
            require('treesitter-context').go_to_context(vim.v.count1)
          end
        end,
        desc = 'Jump to context (previous change in diff mode)',
      },
    },
  },

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

  -- markdown reviewer
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },


})
-- vim.cmd [[colorscheme tokyonight]] -- set colorscheme to tokyonight
