return {
	"zbirenbaum/copilot.lua",
	event = "VeryLazy",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-y>",
				},
			},
			panel = { enabled = false },
		})
	end,
}
