vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

require("copilot").setup({
  suggestion = {
    enabled     = true,
    auto_trigger = true,
    debounce    = 75,
    keymap = {
      accept  = "<C-a>",
      next    = "<c-j>",
      prev    = "<c-k>",
      dismiss = "<C-e>",
    },
  },
  panel = { enabled = false },
  workspace_folders = {
    "~/projects",
    "~/projects-dplabs",
  },
})

local map = require("utils.keymap").map

map("<leader>ct", "<cmd>Copilot toggle<cr>", "Copilot", "Toggle Copilot (current buffer)", { silent = true })
map("<leader>cd", "<cmd>Copilot disable<cr>", "Copilot", "Disable Copilot", { silent = true })
map("<leader>cs", "<cmd>Copilot status<cr>",  "Copilot", "Show Copilot status", { silent = true })
