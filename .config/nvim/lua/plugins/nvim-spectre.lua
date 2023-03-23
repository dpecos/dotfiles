return {
  'windwp/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    {'<leader>S', '<cmd>lua require("spectre").open()<CR>', desc = "Open Spectre" },
    {'<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
    {'<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word", mode = 'v'},
    {'<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search on current file" }
  }
}
