-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- autoload plugins file upon changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  local use = use
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- use 'itchyny/lightline.vim'
  use ({
      'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function() 
        require('themes/eviline') 
      end,
  })
  -- check back once  https://github.com/preservim/nerdtree/issues/1321 is resolved
  use 'preservim/nerdtree'
  use ({
    '0x00-ketsu/autosave.nvim',
    config = function() require('autosave').setup{} end,
  })
  use 'Konfekt/FastFold'
  use 'andymass/vim-matchup'
  use 'bkegley/gloombuddy'
  use 'cappyzawa/starlark.vim'
  use 'dag/vim-fish'
  use 'glench/vim-jinja2-syntax'
  use 'google/vim-jsonnet'
  use 'grafana/vim-alloy'
  use { 
    'haggishunk/the-vapors.nvim',
    branch='modify-main-color'
  }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'jremmen/vim-ripgrep'
  use 'kien/ctrlp.vim'
  use 'neovim/nvim-lspconfig'
  use 'nickeb96/fish.vim'
  use 'nvim-lua/plenary.nvim'
  use 'petertriho/cmp-git'
  use 'ray-x/go.nvim'
  -- use 'santiagovrancovich/nerdtree'
  use 'terryma/vim-expand-region'
  use {
    'tjdevries/colorbuddy.nvim',
    tag='v1.0.0',
  } 
  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {}
    end
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'sharkdp/fd'
  use 'tmhedberg/SimpylFold'
  use 'towolf/vim-helm'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-surround'

  -- circle back for matchup integration https://github.com/andymass/vim-matchup#tree-sitter-integration
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'elixir', 'hcl',
          'html', 'markdown', 'python', 'racket', 'vim', 'tex', 'yaml',
          'yml', 'json', 'smarty', 'dockerfile'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  use {
      'chipsenkbeil/distant.nvim',
      branch = 'v0.3',
      config = function()
          require('distant'):setup()
      end
  }

end)
