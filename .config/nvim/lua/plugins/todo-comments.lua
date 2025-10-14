return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  event = 'VeryLazy',
  config = function()
    require("todo-comments").setup {
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
    }

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "TodoComments: Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "TodoComments: Previous todo comment" })

    vim.keymap.set('n', '<leader>ft', ':TodoTelescope<CR>', { desc = 'TodoComments: List all TODOs' })
  end
}
