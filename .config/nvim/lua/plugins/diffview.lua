return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "DiffviewOpen",
	config = function()
		local cb = require("diffview.config").diffview_callback

		require("diffview").setup({})
	end,
}
