return {
	"zbirenbaum/copilot.lua",
	build = ":Copilot auth",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-a>",
					next = "<c-j>",
					prev = "<c-k>",
					dismiss = "<C-e>",
				},
			},
			panel = { enabled = false },
		})
	end,
}
