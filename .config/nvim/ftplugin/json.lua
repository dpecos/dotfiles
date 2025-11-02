local map = require("utils.keymap").map

map("o",
  function()
    local line = vim.api.nvim_get_current_line()

    local should_add_comma = string.find(line, '[^,{[]$')
    if should_add_comma then
      return 'A,<cr>'
    else
      return 'o'
    end
  end,
  'JSON',
  'Add comma on new line if needed',
  { buffer = true, expr = true }
)
