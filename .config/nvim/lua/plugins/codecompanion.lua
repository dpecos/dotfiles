return {
	"olimorris/codecompanion.nvim",
	opts = {
		extensions = {},
		adapters = {
			copilot = function()
				return require("codecompanion.adapters").extend("copilot", {
					schema = {
						model = {
							-- default = "gemini-2.5-pro",
						},
					},
				})
			end,
		},
	},
	keys = {
		{ "<leader>ic", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion" },
		{ "<leader>iC", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
		{ "<leader>ia", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
		{ "<leader>id", "<cmd>CodeCompanionCmd<cr>", desc = "CodeCompanion CMD" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
				cmd = {
					adapter = "copilot",
				},
			},
			display = {
				action_palette = {},
			},
		})
	end,
}
