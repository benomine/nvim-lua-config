local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/plugins/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup({ function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-github.nvim' }
  use { 'nvim-telescope/telescope-packer.nvim' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-rhubarb' }
  use { 'tpope/vim-fugitive' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'akinsho/bufferline.nvim', tag = 'v2.*' }
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient').enable_profile()
    end,
  }
  use { "ahmedkhalf/project.nvim" }
  use { "nvim-lualine/lualine.nvim" }
  use {
    'tiagovla/scope.nvim',
    config = function()
      require('scope').setup()
    end
  }
  use { "kylechui/nvim-surround", config = function()
    require('nvim-surround').setup()
  end
  }
  use { 'ryanoasis/vim-devicons' }
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
    end
  }
  use { 'ap/vim-css-color' }
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use { 'RRethy/vim-illuminate' }

  -- Colorscheme
  use { 'rafi/awesome-vim-colorschemes' }
  use { 'EdenEast/nightfox.nvim' }
  use { 'lunarvim/darkplus.nvim' }

  -- Dashboard --
  use { 'goolord/alpha-nvim' }
  use { 'folke/which-key.nvim' }

  -- TreeSitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- LSP / Dap / Snippets / Formatting / Completion
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { 'ray-x/lsp_signature.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'tami5/lspsaga.nvim' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-emoji' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }
  use { 'onsails/lspkind-nvim' }
  use { 'b0o/schemastore.nvim' }
  use { 'mattn/emmet-vim' }
  use { 'mfussenegger/nvim-jdtls' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'vim-test/vim-test' }
  use { 'folke/lsp-colors.nvim' }
  use { 'akinsho/flutter-tools.nvim' }
  use { 'OmniSharp/omnisharp-vim' }
  use { 'dense-analysis/ale' }
  use { 'SmiteshP/nvim-navic' }
  use { 'mfussenegger/nvim-dap' }
  -- use { 'Pocco81/DAPInstall.nvim' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'simrat39/rust-tools.nvim' }
  use {
    'saecki/crates.nvim',
    config = function()
      require('crates').setup()
    end,
  }

  use {
    'ThePrimeagen/refactoring.nvim',
    config = function()
      require('refactoring').setup()
    end
  }

  use {
    'ThePrimeagen/harpoon',
    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        }
      })
    end
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

end,
  config = {
    display = {
      open_fn = require('packer').float,
    }
  }
})
