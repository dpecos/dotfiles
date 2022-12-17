local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


local packer = require('packer')

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- lua plugin manager

  --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax highlight
  --use 'neovim/nvim-lspconfig'
  
  if packer_bootstrap then
    require('packer').sync()
  end
end)

