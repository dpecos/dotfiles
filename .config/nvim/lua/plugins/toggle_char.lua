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
