vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/windwp/nvim-spectre",
})

local map = require("utils.keymap").map

map("<leader>S",  function() require("spectre").open() end,
  "Spectre", "Open Spectre")
map("<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,
  "Spectre", "Search current word")
map("<leader>sw", function() require("spectre").open_visual() end,
  "Spectre", "Search current word", { mode = "v" })
map("<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end,
  "Spectre", "Search on current file")
