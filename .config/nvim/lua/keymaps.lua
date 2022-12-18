-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Quicky escape to normal mode
vim.keymap.set("i", "jk", "<esc>")

-- exit vim without saving
vim.api.nvim_set_keymap('n', '<C-q>', ':qa!<CR>', {})

-- Allow gf to open non-existent files
vim.keymap.set("n", "gf", ":edit<cfile><CR>")

--vim.api.nvim_set_keymap('n', '<leader>vr', ':source $MYVIMRC<CR>', { desc = 'Reload NeoVim config' })
vim.api.nvim_set_keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>', { desc = 'Edit init file' })
vim.api.nvim_set_keymap('n', '<leader>vk', ':edit ~/.config/nvim/lua/keymaps.lua<CR>', { desc = 'Edit keymaps file' })
vim.api.nvim_set_keymap('n', '<leader>vp', ':edit ~/.config/nvim/lua/plugins.lua<CR>', { desc = 'Edit plugins file' })
vim.api.nvim_set_keymap('n', '<leader>vs', ':edit ~/.config/nvim/lua/settings.lua<CR>', { desc = 'Edit settings file' })

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--
-- Keep movements centered
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Better tabbing: reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

--
-- Select pasted text
vim.cmd("nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- Paste replace visual selection without copying it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

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

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- vim.keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- vim.keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- vim.keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- vim.keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- classic mistakes
-- saving with :W instead of :w
vim.cmd("cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))")
