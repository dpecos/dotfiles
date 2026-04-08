-- Nvim Spectre
-- https://github.com/nvim-pack/nvim-spectre
--
-- Find and replace across multiple files with live preview and regex support

local map = require("utils.keymap").map

map("<leader>S",  function() require("spectre").open() end,
  "Spectre", "Open Spectre")
map("<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,
  "Spectre", "Search current word")
map("<leader>sw", function() require("spectre").open_visual() end,
  "Spectre", "Search current word", { mode = "v" })
map("<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end,
  "Spectre", "Search on current file")
