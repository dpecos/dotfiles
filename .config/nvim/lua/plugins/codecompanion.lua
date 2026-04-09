vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/olimorris/codecompanion.nvim",
})

require("codecompanion").setup({
  extensions = {},
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            -- default = "gemini-2.5-pro",
          },
        },
      })
    end,
  },
  strategies = {
    chat   = { adapter = "copilot" },
    inline = { adapter = "copilot" },
    cmd    = { adapter = "copilot" },
  },
  display = {
    action_palette = {},
  },
})

local map = require("utils.keymap").map

map("<leader>ic", "<cmd>CodeCompanion<cr>",        "CodeCompanion", "CodeCompanion")
map("<leader>iC", "<cmd>CodeCompanionChat<cr>",    "CodeCompanion", "CodeCompanion Chat")
map("<leader>ia", "<cmd>CodeCompanionActions<cr>", "CodeCompanion", "CodeCompanion Actions")
map("<leader>id", "<cmd>CodeCompanionCmd<cr>",     "CodeCompanion", "CodeCompanion CMD")
