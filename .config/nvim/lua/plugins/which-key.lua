-- Which Key
-- https://github.com/folke/which-key.nvim
--
-- Display keybinding popup as you type to help discover available keymaps
-- Shows grouped keybindings by prefix with descriptions

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    wk.setup({
      reset = "helix",
      plugins = {
        marks = false,
        operators = false,
        windows = false,
        nav = false,
      },
      win = {
        padding = { 0, 1 },
        title = false,
        border = "rounded", -- none, single, double, shadow, rounded
      },
    })

    local map = require("utils.keymap").map

    map("<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      "Wchich Key",
      "Buffer Local Keymaps"
    )
  end,
}
