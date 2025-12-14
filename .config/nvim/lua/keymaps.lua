-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = require("utils.keymap").map

-- Quicky escape to normal mode
map("jk", "<esc>", "Neovim", "Exit insert mode with jk", { mode = "i" })

-- exit vim without saving
map("<C-q>", ":qa!<CR>", "Neovim", "Quit all without saving")

-- Allow gf to open non-existent files
map("gf", ":edit <cfile><CR>", "Neovim", "Open file under cursor (create if needed)")

-- clear search highlights
map("<leader>nh", ":nohl<CR>", "Neovim", "Clear search highlights")

--vim.api.nvim_set_keymap('n', '<leader>vr', ':source $MYVIMRC<CR>', { desc = 'Neovim: Reload NeoVim config' })
map("<leader>ve", ":edit ~/.config/nvim/init.lua<CR>", "Neovim", "Edit init file")
map("<leader>vk", ":edit ~/.config/nvim/lua/keymaps.lua<CR>", "Neovim", "Edit keymaps file")
map("<leader>vp", ":edit ~/.config/nvim/lua/plugins.lua<CR>", "Neovim", "Edit plugins file")
map("<leader>vs", ":edit ~/.config/nvim/lua/settings.lua<CR>", "Neovim", "Edit settings file")

-- Remap for dealing with word wrap
map("k", "v:count == 0 ? 'gk' : 'k'", "Neovim", "Move up (wrapped lines)", { expr = true, silent = true })
map("j", "v:count == 0 ? 'gj' : 'j'", "Neovim", "Move down (wrapped lines)", { expr = true, silent = true })

-- Move selected lines up and down
map("J", ":m '>+1<CR>gv=gv", "Neovim", "Move selected line down", { mode = "v" })
map("K", ":m '<-2<CR>gv=gv", "Neovim", "Move selected line up", { mode = "v" })

-- Keep movements centered
map("J", "mzJ`z", "Neovim", "Join line below (keep cursor)")
map("<C-d>", "<C-d>zz", "Neovim", "Scroll down (centered)")
map("<C-u>", "<C-u>zz", "Neovim", "Scroll up (centered)")
map("n", "nzzzv", "Neovim", "Next search result (centered)")
map("N", "Nzzzv", "Neovim", "Previous search result (centered)")

-- Better tabbing: reselect visual selection after indenting
map("<", "<gv", "Neovim", "Indent left (keep selection)", { mode = "v" })
map(">", ">gv", "Neovim", "Indent right (keep selection)", { mode = "v" })

-- copy / paste / delete to system clipboard
map("<leader>y", '"+y', "Neovim", "Yank to system clipboard", { mode = { "n", "v" } })
map("<leader>Y", '"+Y', "Neovim", "Yank line to system clipboard", { mode = { "n", "v" } })
map("<leader>p", '"+p', "Neovim", "Paste from system clipboard", { mode = { "n", "v" } })
map("<leader>P", '"+P', "Neovim", "Paste from system clipboard (before)", { mode = { "n", "v" } })
map("<leader>d", '"_d', "Neovim", "Delete to black hole register", { mode = { "n", "v" } })
map("<C-v>", '<Esc>"+pa', "Neovim", "Paste from system clipboard (insert)", { mode = "i" })

-- Paste over currently selected text without yanking it
map("p", '"_dP', "Neovim", "Paste over selection (keep register)", { mode = "v" })

-- Delete without copying
map("<leader>d", [["_d]], "Neovim", "Delete to black hole register", { mode = { "n", "v" } })

-- don't yank an empty line into your default register (https://www.reddit.com/r/neovim/comments/12rqyl8/5_smart_minisnippets_for_making_text_editing_more/)
map("dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, "Neovim", "Delete line (empty lines to black hole)", { expr = true })

-- Select pasted text
vim.cmd("nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
map("y", "myy`y", "Neovim", "Yank (keep cursor position)", { mode = "v" })
map("Y", "myY`y", "Neovim", "Yank line (keep cursor position)", { mode = "v" })

-- split
map("<C-w>h", ":split<Return>", "Neovim", "Horizontal split")
map("<C-w>v", ":vsplit<Return>", "Neovim", "Vertical split")

-- split resize
map("<C-w><Left>", "<C-w><5", "Neovim", "Increase split size - left")
map("<C-w><Right>", "<C-w>>5", "Neovim", "Increase split size - right")
map("<C-w><Up>", "<C-w>+5", "Neovim", "Increase split size - up")
map("<C-w><Down>", "<C-w>-5", "Neovim", "Increase split size - down")

-- classic mistakes
-- saving with :W instead of :w
vim.cmd("cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))")

-- Toggle between single, double, and backtick quotes
map("<leader>tq", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col "."
  local new_line = line:gsub("(['\"`])(.-[^\\])%1", function(q, content)
    if q == "'" then
      return '"' .. content .. '"'
    elseif q == '"' then
      return "`" .. content .. "`"
    else
      return "'" .. content .. "'"
    end
  end)
  vim.api.nvim_set_current_line(new_line)
  vim.fn.cursor(vim.fn.line ".", col)
end, "Neovim", "Toggle quote style")
