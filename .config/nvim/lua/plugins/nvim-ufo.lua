vim.pack.add({
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/kevinhwang91/nvim-ufo",
})

vim.o.foldcolumn    = "0"
vim.o.foldlevel     = 99
vim.o.foldlevelstart = 99
vim.o.foldenable    = true

local map = require("utils.keymap").map
local ufo = require("ufo")

map("zR", ufo.openAllFolds,  "UFO", "Open all folds")
map("zM", ufo.closeAllFolds, "UFO", "Close all folds")

ufo.setup()
