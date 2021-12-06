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

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

  use 'preservim/nerdtree'

  use 'vim-airline/vim-airline'
  use 'rafi/awesome-vim-colorschemes'
  use 'ryanoasis/vim-devicons'
  use 'tc50cal/vim-terminal'
  use 'github/copilot.vim'
  use 'wfxr/minimap.vim'
  use 'voldikss/vim-floaterm'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-github.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'

  use 'ray-x/lsp_signature.nvim'
  use 'neovim/nvim-lspconfig'
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

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

  require('lspsaga').init_lsp_saga()

  require('luasnip.loaders.from_vscode').lazy_load()

  require('nvim-treesitter.configs').setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

end,
config = {
    display = {
        open_fn = require('packer').float,
    }
}})
