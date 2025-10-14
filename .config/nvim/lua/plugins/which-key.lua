-- Which Key
-- https://github.com/folke/which-key.nvim
--
-- Display keybinding popup as you type to help discover available keymaps
-- Shows grouped keybindings by prefix with descriptions

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		
		wk.setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20,
				},
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			win = {
				border = "rounded", -- none, single, double, shadow, rounded
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
		})

		-- Document existing key chains
		wk.add({
			{ "<leader>c", group = "Crates (Rust)" },
			{ "<leader>d", group = "Diagnostics/Delete" },
			{ "<leader>f", group = "Find (Telescope)" },
			{ "<leader>g", group = "Git (Fugitive)" },
			{ "<leader>h", group = "Hunk (Git)" },
			{ "<leader>n", group = "Nvim-tree/No" },
			{ "<leader>o", group = "Organize (TS/JS)" },
			{ "<leader>r", group = "Rust/Refactor" },
			{ "<leader>s", group = "Search/Replace (Spectre)" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>v", group = "Vim config" },
			{ "<leader>w", group = "Window/Workspace" },
			{ "g", group = "Go to (LSP)" },
			{ "[", group = "Previous" },
			{ "]", group = "Next" },
		})
	end,
}
