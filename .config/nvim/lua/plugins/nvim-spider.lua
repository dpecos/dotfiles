-- Nvim Spider
-- https://github.com/chrisgrieser/nvim-spider
--
-- Enhanced word motion that skips punctuation and handles camelCase/snake_case intelligently
-- Overrides: w, e, b, ge with smarter movement patterns
-- More natural navigation for modern programming with compound identifiers

return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  keys = {
    { "w",  "<cmd>lua require('spider').motion('w')<CR>",  desc = "Spider-w" },
    { "e",  "<cmd>lua require('spider').motion('e')<CR>",  desc = "Spider-e" },
    { "b",  "<cmd>lua require('spider').motion('b')<CR>",  desc = "Spider-b" },
    { "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
  }
}
