-- Nvim Spider
-- https://github.com/chrisgrieser/nvim-spider
--
-- Enhanced word motion for camelCase/snake_case

local map = require("utils.keymap").map

map("w",  function() require("spider").motion("w")  end, "Spider", "Spider-w")
map("e",  function() require("spider").motion("e")  end, "Spider", "Spider-e")
map("b",  function() require("spider").motion("b")  end, "Spider", "Spider-b")
map("ge", function() require("spider").motion("ge") end, "Spider", "Spider-ge")
