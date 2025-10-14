-- Dressing.nvim - Better UI for vim.ui.select and vim.ui.input
-- 
-- Enhances native Neovim UI elements with better interfaces:
-- • vim.ui.select → Telescope picker (when available) or custom picker
-- • vim.ui.input → Better input dialog with border and highlighting
--
-- Used by:
-- • LSP code actions
-- • LSP rename
-- • Plugin selections
-- • Any plugin using native vim.ui

return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			-- Set to false to disable the vim.ui.input implementation
			enabled = true,
			-- Default prompt string
			default_prompt = "Input:",
			-- Can be 'left', 'right', or 'center'
			title_pos = "left",
			-- When true, <Esc> will close the modal
			insert_only = true,
			-- When true, input will start in insert mode
			start_in_insert = true,
			-- These are passed to nvim_open_win
			border = "rounded",
			-- 'editor' and 'win' will default to being centered
			relative = "cursor",
			-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			prefer_width = 40,
			width = nil,
			max_width = { 140, 0.9 },
			min_width = { 20, 0.2 },
			win_options = {
				-- Window-local options to use for the input window
				winblend = 0,
				wrap = false,
				list = true,
				listchars = "precedes:…,extends:…",
				sidescrolloff = 0,
			},
			-- Set to `false` to disable
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev",
					["<Down>"] = "HistoryNext",
				},
			},
		},
		select = {
			-- Set to false to disable the vim.ui.select implementation
			enabled = true,
			-- Priority list of preferred vim.select implementations
			backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
			-- Trim trailing `:` from prompt
			trim_prompt = true,
			-- Options for telescope selector
			telescope = require("telescope.themes").get_dropdown({
				-- borderchars = {
				-- 	{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- 	prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
				-- 	results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
				-- 	preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- },
			}),
			-- Options for built-in selector
			builtin = {
				-- Display numbers for options and set up keymaps
				show_numbers = true,
				-- These are passed to nvim_open_win
				border = "rounded",
				-- 'editor' and 'win' will default to being centered
				relative = "editor",
				win_options = {
					-- Window-local options to use for the select window
					cursorline = true,
					cursorlineopt = "both",
					winblend = 0,
				},
				-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				width = nil,
				max_width = { 140, 0.8 },
				min_width = { 40, 0.2 },
				height = nil,
				max_height = 0.9,
				min_height = { 10, 0.2 },
				-- Set to `false` to disable
				mappings = {
					["<Esc>"] = "Close",
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
				},
			},
		},
	},
}
