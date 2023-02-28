local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


local packer = require('packer')

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- lua plugin manager

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use { 'hrsh7th/nvim-cmp', }
  -- nvim-cmp dependencies but can't be listed as requires because of lazyloading
  use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    }
  }

  use 'tpope/vim-commentary'

  use 'tpope/vim-fugitive'

  use 'tpope/vim-surround'

  use 'windwp/nvim-autopairs'

  use 'editorconfig/editorconfig-vim'

  use "mhartington/formatter.nvim"

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', opt = true
    },
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons', opt = true
    },
  }

  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use 'nvim-tree/nvim-web-devicons'
  use { 'romgrk/barbar.nvim',
    wants = {
      'nvim-web-devicons'
    },
  }

  use 'lukas-reineke/indent-blankline.nvim'

  use { 'Mofiqul/vscode.nvim' } -- Theme

  use { 'jtdowney/vimux-cargo' }
  use { 'tyewang/vimux-jest-test' }
  use { 'preservim/vimux', -- Interact with Tmux panes
    wants = {
      { 'vimux-cargo', opt = true },
      { 'vimux-jest-test', opt = true },
    },
  }

  use { 'christoomey/vim-tmux-navigator' }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use 'mbbill/undotree'

  use 'j-hui/fidget.nvim'

  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

  use { 'lewis6991/gitsigns.nvim' }

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim"
  }

  use { 'propet/toggle-fullscreen.nvim' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
