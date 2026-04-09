vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

require("todo-comments").setup({
  colors = {
    error   = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info    = { "DiagnosticInfo", "#2563EB" },
    hint    = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test    = { "Identifier", "#FF00FF" },
  },
})

local map = require("utils.keymap").map

map("]t", function() require("todo-comments").jump_next() end, "TodoComments", "Next todo comment")
map("[t", function() require("todo-comments").jump_prev() end, "TodoComments", "Previous todo comment")

map("<leader>st", function()
  Snacks.picker.todo_comments()
end, "TODOs", "Show all TODO Comments")

map("<leader>sT", function()
  Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
end, "TODOs", "TODO/FIX/FIXME Comments")
