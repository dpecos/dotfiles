-- Nvim Spectre
-- https://github.com/nvim-pack/nvim-spectre
--
-- Find and replace across multiple files with live preview and regex support
-- Keymaps: <leader>S (open), <leader>sw (search word), <leader>sp (search in file)

return {
  'windwp/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    { '<leader>S',  '<cmd>lua require("spectre").open()<CR>',                               desc = "Spectre: Open Spectre" },
    { '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',      desc = "Spectre: Search current word" },
    { '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',                   desc = "Spectre: Search current word",   mode = 'v' },
    { '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Spectre: Search on current file" }
  }
}
