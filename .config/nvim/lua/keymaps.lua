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

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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

-- copy / paste to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+Y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y$')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set("i", "<C-v>", "<Esc>\"+pa")

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP')

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Select pasted text
vim.cmd("nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- split
vim.keymap.set("n", "<C-w>f", function()
  require("nvim-tree.api").tree.close()
  require("toggle-fullscreen"):toggle_fullscreen()
end, { desc = 'Toggle split fullscreen' })

-- split resize
vim.keymap.set("n", "<C-w><Left>", "<C-w><5", { desc = "Increase split size - left" })
vim.keymap.set("n", "<C-w><Right>", "<C-w>>5", { desc = "Increase split size - right" })
vim.keymap.set("n", "<C-w><Up>", "<C-w>+5", { desc = "Increase split size - up" })
vim.keymap.set("n", "<C-w><Down>", "<C-w>-5", { desc = "Increase split size - down" })

-- classic mistakes
-- saving with :W instead of :w
vim.cmd("cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))")

-- don't yank an empty line into your default register (https://www.reddit.com/r/neovim/comments/12rqyl8/5_smart_minisnippets_for_making_text_editing_more/)
vim.keymap.set("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })
