-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Quicky escape to normal mode
vim.keymap.set("i", "jk", "<esc>", { desc = "Neovim: Exit insert mode with jk" })

-- exit vim without saving
vim.keymap.set("n", "<C-q>", ":qa!<CR>", { desc = "Neovim: Quit all without saving" })

-- Allow gf to open non-existent files
vim.keymap.set("n", "gf", ":edit <cfile><CR>", { desc = "Neovim: Open file under cursor (create if needed)" })

--vim.api.nvim_set_keymap('n', '<leader>vr', ':source $MYVIMRC<CR>', { desc = 'Neovim: Reload NeoVim config' })
vim.keymap.set("n", "<leader>ve", ":edit ~/.config/nvim/init.lua<CR>", { desc = "Neovim: Edit init file" })
vim.keymap.set("n", "<leader>vk", ":edit ~/.config/nvim/lua/keymaps.lua<CR>", { desc = "Neovim: Edit keymaps file" })
vim.keymap.set("n", "<leader>vp", ":edit ~/.config/nvim/lua/plugins.lua<CR>", { desc = "Neovim: Edit plugins file" })
vim.keymap.set("n", "<leader>vs", ":edit ~/.config/nvim/lua/settings.lua<CR>", { desc = "Neovim: Edit settings file" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Neovim: Move up (wrapped lines)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Neovim: Move down (wrapped lines)" })

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Neovim: Move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Neovim: Move selected line up" })

-- Keep movements centered
vim.keymap.set("n", "J", "mzJ`z", { desc = "Neovim: Join line below (keep cursor)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Neovim: Scroll down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Neovim: Scroll up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Neovim: Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Neovim: Previous search result (centered)" })

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Neovim: Clear search highlights" })

-- Better tabbing: reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Neovim: Indent left (keep selection)" })
vim.keymap.set("v", ">", ">gv", { desc = "Neovim: Indent right (keep selection)" })

-- copy / paste / delete to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Neovim: Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Neovim: Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Neovim: Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Neovim: Paste from system clipboard (before)" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Neovim: Delete to black hole register" })
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { desc = "Neovim: Paste from system clipboard (insert)" })

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', { desc = "Neovim: Paste over selection (keep register)" })

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Neovim: Delete to black hole register" })

-- Select pasted text
vim.cmd("nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y", { desc = "Neovim: Yank (keep cursor position)" })
vim.keymap.set("v", "Y", "myY`y", { desc = "Neovim: Yank line (keep cursor position)" })

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- split
vim.keymap.set("n", "<C-w>h", ":split<Return>", { desc = "Neovim: Horizontal split" })
vim.keymap.set("n", "<C-w>v", ":vsplit<Return>", { desc = "Neovim: Vertical split" })

vim.keymap.set("n", "<C-w>f", function()
	require("nvim-tree.api").tree.close()
	require("toggle-fullscreen"):toggle_fullscreen()
end, { desc = "Toggle Fullscreen: Toggle split fullscreen" })

-- split resize
vim.keymap.set("n", "<C-w><Left>", "<C-w><5", { desc = "Neovim: Increase split size - left" })
vim.keymap.set("n", "<C-w><Right>", "<C-w>>5", { desc = "Neovim: Increase split size - right" })
vim.keymap.set("n", "<C-w><Up>", "<C-w>+5", { desc = "Neovim: Increase split size - up" })
vim.keymap.set("n", "<C-w><Down>", "<C-w>-5", { desc = "Neovim: Increase split size - down" })

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
end, { expr = true, desc = "Neovim: Delete line (empty lines to black hole)" })

-- close quickfix / locations menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})
