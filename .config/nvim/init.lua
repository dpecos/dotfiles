-- Silence vim.tbl_flatten deprecation from third-party plugins that haven't updated yet
---@diagnostic disable-next-line: deprecated
vim.tbl_flatten = function(t) return vim.iter(t):flatten():totable() end

require('vim._core.ui2').enable()

require("keymaps")
require("settings")
require("autocmds")
require("plugins")
require("utils.native-completion")
require("utils.typescript-tools")
