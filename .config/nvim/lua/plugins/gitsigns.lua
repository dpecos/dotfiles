-- Gitsigns
-- https://github.com/lewis6991/gitsigns.nvim
--
-- Git integration with gutter signs for added, modified, and deleted lines
-- Keymaps: ]c/[c (next/prev hunk), <leader>hs (stage hunk), <leader>hr (reset hunk)
-- Features: inline blame, hunk preview, diff view, and stage/unstage hunks
-- Integrated with LSP config for comprehensive git workflow

return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup()
  end
}
