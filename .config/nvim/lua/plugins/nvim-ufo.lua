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

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "UFO: Open all folds" })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "UFO: Close all folds" })

    require('ufo').setup()
  end,
}
