# Installation des LSP

Aller voir le lien : [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) pour l'ensemble des LSP disponibles et comment les installer.

* Quelques exemples (nécessitent d'avoir node installé ainsi que yarn) :

``npm i -g vscode-langservers-extracted``

``npm install -g dockerfile-language-server-nodejs``

``npm install -g typescript typescript-language-server``

``npm install -g vim-language-server``

``npm install -g @tailwindcss/language-server``

``yarn global add yaml-language-server``

``npm install -g vls``

* Pour Omnisharp :

Aller sur le lien [Omnisharp](https://github.com/OmniSharp/omnisharp-roslyn/releases) pour télécharger les dernières release.

* Pour Ltex-ls :

Aller sur le lien [Ltex](https://github.com/valentjn/ltex-ls/releases) pour télécharger les dernières release.

* Utilisation de snippets, ici [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

``use "rafamadriz/friendly-snippets"``
``require("luasnip/loaders/from_vscode").lazy_load()``


# Installation de Minimap

* Installation nécessaire de [🛰 code-minimap](https://github.com/wfxr/code-minimap)

``scoop bucket add extras``
``scoop install code-minimap``

* Installation via packer
``use 'wfxr/minimap.vim'``


