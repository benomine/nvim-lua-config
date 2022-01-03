local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/plugins/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[packadd packer.nvim]])

return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-fugitive'

  use 'preservim/nerdtree'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'rafi/awesome-vim-colorschemes'
  use 'lunarvim/darkplus.nvim'
  use 'Mofiqul/codedark.nvim'
  use 'folke/tokyonight.nvim'
  use 'ryanoasis/vim-devicons'
  use 'tc50cal/vim-terminal'
  use 'github/copilot.vim'
  use 'wfxr/minimap.vim'
  use 'voldikss/vim-floaterm'
  use 'ap/vim-css-color'
  use 'rebelot/kanagawa.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-github.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'
  use 'nvim-telescope/telescope-packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- Dashboard --
  use {
   'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.opts)
    end
  }
  use 'folke/which-key.nvim'

  -- TreeSitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'

  -- LSP
  use 'williamboman/nvim-lsp-installer'
  use 'ray-x/lsp_signature.nvim'
  use 'neovim/nvim-lspconfig'
  use 'tami5/lspsaga.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-emoji'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'
  use 'b0o/schemastore.nvim'
  use 'mattn/emmet-vim'
  use 'mfussenegger/nvim-jdtls'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'vim-test/vim-test'
  use 'folke/lsp-colors.nvim'
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

  require('lualine').setup {
    options = {
      theme = "kanagawa"
    }
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
