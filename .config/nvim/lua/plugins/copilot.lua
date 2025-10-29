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

    vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<cr>",
      { desc = "Copilot: Toggle Copilot (current buffer)", silent = true })

    vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<cr>",
      { desc = "Copilot: Disable Copilot", silent = true })

    vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<cr>",
      { desc = "Copilot: Show Copilot status", silent = true })
  end,
}
