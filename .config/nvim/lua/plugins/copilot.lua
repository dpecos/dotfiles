return {
  'zbirenbaum/copilot-cmp',
  dependencies = {
    "zbirenbaum/copilot.lua",
  },
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-y>"
        }
      },
      panel = { enabled = false },
    })

    require('copilot_cmp').setup()
  end
}
