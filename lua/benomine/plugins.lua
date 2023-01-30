vim.opt.termguicolors = true

local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
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
   'nvim-telescope/telescope.nvim',
   'nvim-telescope/telescope-github.nvim',
   'nvim-telescope/telescope-packer.nvim',
   'tpope/vim-commentary',
   'tpope/vim-surround',
   'tpope/vim-rhubarb',
   'tpope/vim-fugitive',
   'kyazdani42/nvim-web-devicons',
   'kyazdani42/nvim-tree.lua',
   'akinsho/bufferline.nvim',
   'lunarvim/peek.lua',
   {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient').enable_profile()
    end,
   },
   {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({
        text = { spinner = "dots", },
        window = { blend = 0, relative = "editor" },
      })
    end,
   },
   "ahmedkhalf/project.nvim",
   "nvim-lualine/lualine.nvim",
   {
    'tiagovla/scope.nvim',
    config = function()
      require('scope').setup()
    end
   },
   {
    "kylechui/nvim-surround", config = function()
      require('nvim-surround').setup()
    end
   },
   'ryanoasis/vim-devicons',
   {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
    end
   },
   'ap/vim-css-color',
   'nvim-lua/popup.nvim',
   'nvim-lua/plenary.nvim',
   'lewis6991/gitsigns.nvim',
   {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
   },
   {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
   },
   'RRethy/vim-illuminate',
  -- Colorscheme
   'rafi/awesome-vim-colorschemes',
   'EdenEast/nightfox.nvim',
   'lunarvim/darkplus.nvim',
   'folke/tokyonight.nvim',
   'rebelot/kanagawa.nvim',
   'Mofiqul/vscode.nvim',

  -- Dashboard --
   'goolord/alpha-nvim',
   'folke/which-key.nvim',

  -- TreeSitter
   { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- LSP / Dap / Snippets / Formatting / Completion
   "williamboman/mason.nvim",
   "williamboman/mason-lspconfig.nvim",
   'ray-x/lsp_signature.nvim',
   'neovim/nvim-lspconfig',
   'tami5/lspsaga.nvim',
   'hrsh7th/nvim-cmp',
   'hrsh7th/cmp-path',
   'hrsh7th/cmp-cmdline',
   'hrsh7th/cmp-emoji',
   'hrsh7th/vim-vsnip',
   'hrsh7th/vim-vsnip-integ',
   'hrsh7th/cmp-nvim-lsp',
   'hrsh7th/cmp-nvim-lua',
   'L3MON4D3/LuaSnip',
   'rafamadriz/friendly-snippets',
   'onsails/lspkind-nvim',
   'b0o/schemastore.nvim',
   'mattn/emmet-vim',
   'mfussenegger/nvim-jdtls',
   'jose-elias-alvarez/null-ls.nvim',
   'vim-test/vim-test',
   'folke/lsp-colors.nvim',
  --  'OmniSharp/omnisharp-vim',
   'dense-analysis/ale',
   'SmiteshP/nvim-navic',
   'mfussenegger/nvim-dap',
   'rcarriga/nvim-dap-ui',
   'simrat39/rust-tools.nvim',
   {
    'saecki/crates.nvim',
    config = function()
      require('crates').setup()
    end,
   },

   {
    'ThePrimeagen/refactoring.nvim',
    config = function()
      require('refactoring').setup()
    end
   },

   "olexsmir/gopher.nvim",
   "leoluz/nvim-dap-go",

   {
    'ThePrimeagen/harpoon',
    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        }
      })
    end
   },
   {
    "benomine/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
   }
})
