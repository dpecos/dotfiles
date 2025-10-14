-- Toggle Char
-- Local plugin
--
-- Toggle between characters (comma and semicolon) at the end of lines
-- Useful for switching between different syntax requirements in multi-paradigm codebases
-- Configured keys: , and ;

return {
	dir = "~/.config/nvim/lua/plugins/local/toggle_char.nvim",
	name = "toggle_char.nvim",
	event = "VeryLazy",
	config = function()
		require("toggle_char").setup({
			keys = { ",", ";" },
		})
	end,
}
