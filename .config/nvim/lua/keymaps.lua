-- [[ Basic Keymaps ]]
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

--vim.api.nvim_set_keymap('n', '<leader>vr', ':source $MYVIMRC<CR>', { desc = 'Reload NeoVim config' })
vim.api.nvim_set_keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>', { desc = 'Edit init file' })
vim.api.nvim_set_keymap('n', '<leader>vk', ':edit ~/.config/nvim/lua/keymaps.lua<CR>', { desc = 'Edit keymaps file' })
vim.api.nvim_set_keymap('n', '<leader>vp', ':edit ~/.config/nvim/lua/plugins.lua<CR>', { desc = 'Edit plugins file' })
vim.api.nvim_set_keymap('n', '<leader>vs', ':edit ~/.config/nvim/lua/settings.lua<CR>', { desc = 'Edit settings file' })

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep movements centered
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- Better window navigation
--vim.keymap.set("n", "<C-h>", "<C-w>h")
--vim.keymap.set("n", "<C-j>", "<C-w>j")
--vim.keymap.set("n", "<C-k>", "<C-w>k")
--vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Use alt + hjkl to resize windows
vim.api.nvim_set_keymap('n', '<M-j>', ':resize -2<CR>', {})
vim.api.nvim_set_keymap('n', '<M-k>', ':resize +2<CR>', {})
vim.api.nvim_set_keymap('n', '<M-h>', ':vertical resize -2<CR>', {})
vim.api.nvim_set_keymap('n', '<M-l>', ':vertical resize +2<CR>', {})

-- Buffers
vim.api.nvim_set_keymap('n', '<leader>bd', ':BufferDelete<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bc', ':BufferClose<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bo', ':BufferCloseAllButCurrent<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferPin<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferNext<CR>', {})
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {})
