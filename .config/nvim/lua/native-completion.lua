-- Optional: Native-only completion configuration
-- 
-- This file demonstrates how to use ONLY Neovim's native completion
-- without nvim-cmp. To use this approach:
--
-- 1. Remove or disable lua/plugins/nvim-cmp.lua
-- 2. The native completion is already enabled in nvim-lspconfig.lua
-- 3. Add custom keymaps and configuration as needed
--
-- NOTE: This provides a simpler, lighter setup but with fewer features
-- than nvim-cmp (no snippet sources, fewer completion sources, etc.)

local M = {}

-- Enhanced native completion keymaps
M.setup_keymaps = function()
	-- Insert mode completion keymaps
	local keymap_opts = { noremap = true, silent = true }
	
	-- Trigger LSP completion
	vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", 
		vim.tbl_extend("force", keymap_opts, { desc = "LSP completion" }))
	
	-- Accept completion with Enter (if popup is visible)
	vim.keymap.set("i", "<CR>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-y>"
		else
			return "<CR>"
		end
	end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Accept completion or newline" }))
	
	-- Close completion menu with Escape
	vim.keymap.set("i", "<C-e>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-e>"
		else
			return "<Esc>"
		end
	end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Close completion" }))
	
	-- Navigate completion menu
	vim.keymap.set("i", "<C-n>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-n>"
		else
			return "<C-x><C-o>"
		end
	end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Next completion or trigger" }))
	
	vim.keymap.set("i", "<C-p>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-p>"
		else
			return "<C-x><C-o>"
		end
	end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Previous completion or trigger" }))
	
	-- Tab to accept or move to next completion
	vim.keymap.set("i", "<Tab>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-n>"
		else
			return "<Tab>"
		end
	end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Tab or next completion" }))
	
	vim.keymap.set("i", "<S-Tab>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-p>"
		else
			return "<S-Tab>"
		end
	end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Shift-Tab or previous completion" }))
end

-- Call this function to set up native completion
M.setup = function()
	M.setup_keymaps()
	
	-- Additional native completion configuration
	vim.opt.completeopt = "menu,menuone,noselect"
	vim.opt.pumheight = 15
	vim.opt.pumblend = 10
	
	-- Enable preview window for completion documentation
	vim.opt.completeopt:append("preview")
	
	print("Native LSP completion configured!")
end

-- Uncomment to enable:
-- M.setup()

return M
