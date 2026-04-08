-- Which Key
-- https://github.com/folke/which-key.nvim
--
-- Display keybinding popup as you type

vim.o.timeout    = true
vim.o.timeoutlen = 300

require("which-key").setup({
  reset = "helix",
  plugins = {
    marks     = false,
    operators = false,
    windows   = false,
    nav       = false,
  },
  win = {
    padding = { 0, 1 },
    title   = false,
    border  = "rounded",
  },
})

local map = require("utils.keymap").map

map("<leader>?",
  function() require("which-key").show({ global = false }) end,
  "Which Key",
  "Buffer Local Keymaps"
)
