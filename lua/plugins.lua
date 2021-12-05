local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/plugins/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[packadd packer.nvim]])

return require('packer').startup({function(use)
  use 'tpope/vim-surround'
  use 'preservim/nerdtree'
  use 'tpope/vim-commentary'
  use 'vim-airline/vim-airline'
  use 'rafi/awesome-vim-colorschemes'
  use 'ryanoasis/vim-devicons'
  use 'tc50cal/vim-terminal'
  use 'preservim/tagbar'
  use 'github/copilot.vim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-github.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'ray-x/lsp_signature.nvim'
  use 'voldikss/vim-floaterm'
  use 'neovim/nvim-lspconfig'
  use 'wfxr/minimap.vim'
  use 'tami5/lspsaga.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'
  use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
          require('gitsigns').setup()
      end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end

  require('lspsaga').init_lsp_saga()

  require('luasnip.loaders.from_vscode').lazy_load()

end,
config = {
    display = {
        open_fn = require('packer').float,
    }
}})
