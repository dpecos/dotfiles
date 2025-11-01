-- Nvim UFO
-- https://github.com/kevinhwang91/nvim-ufo
--
-- Modern code folding with better performance and LSP/Treesitter support
-- Keymaps: zR (open all folds), zM (close all folds)
-- High foldlevel (99) by default for better initial view

return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'VeryLazy',
  config = function()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local map = require("utils.keymap").map
    
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    map('zR', require('ufo').openAllFolds, "UFO", "Open all folds")
    map('zM', require('ufo').closeAllFolds, "UFO", "Close all folds")

    require('ufo').setup()
  end,
}
