-- Copilot
-- https://github.com/zbirenbaum/copilot.lua
--
-- GitHub Copilot integration written in pure Lua with inline suggestions
-- Keymaps: Ctrl+a (accept), Ctrl+j/k (next/prev suggestion), Ctrl+e (dismiss)
-- Auto-triggers on insert mode with 75ms debounce

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
