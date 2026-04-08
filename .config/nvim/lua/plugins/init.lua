-- Load plugin configurations in priority order.
-- All plugins are already on rtp via vim.pack.add(); these calls just run setup().

require("plugins.vscode")       -- colorscheme first
require("plugins.snacks")       -- high-priority UI (dashboard, picker, etc.)
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.mason")
require("plugins.lualine")
require("plugins.which-key")
require("plugins.nvim-ufo")
require("plugins.nvim-surround")
require("plugins.nvim-autopairs")
require("plugins.nvim-spider")
require("plugins.mini-comment")
require("plugins.nvim-colorizer")
require("plugins.todo-comments")
require("plugins.nvim-spectre")
require("plugins.copilot")
require("plugins.crates-nvim")
require("plugins.diffview")
require("plugins.codecompanion")
require("plugins.rustaceanvim")
require("plugins.toggle_char")
