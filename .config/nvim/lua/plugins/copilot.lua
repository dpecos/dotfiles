-- Copilot
-- https://github.com/zbirenbaum/copilot.lua
--
-- GitHub Copilot integration written in pure Lua with inline suggestions
-- Keymaps: Ctrl+a (accept), Ctrl+j/k (next/prev suggestion), Ctrl+e (dismiss)
-- Auto-triggers on insert mode with 75ms debounce

return {
  "zbirenbaum/copilot.lua",
  build = ":Copilot auth",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-a>",
          next = "<c-j>",
          prev = "<c-k>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = false },
      workspace_folders = {
        "~/projects",
        "~/projects-dplabs",
      }
    })

    local map = require("utils.keymap").map

    map("<leader>ct", "<cmd>Copilot toggle<cr>", "Copilot", "Toggle Copilot (current buffer)", { silent = true })
    map("<leader>cd", "<cmd>Copilot disable<cr>", "Copilot", "Disable Copilot", { silent = true })
    map("<leader>cs", "<cmd>Copilot status<cr>", "Copilot", "Show Copilot status", { silent = true })
  end,
}
