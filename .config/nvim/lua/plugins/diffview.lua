-- Diffview
-- https://github.com/sindrets/diffview.nvim
--
-- Enhanced diff view for reviewing git changes with file history and merge conflict resolution
-- Commands: :DiffviewOpen (show changes), :DiffviewFileHistory (file history)
-- Better visualization for git diffs compared to built-in diff mode

return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "DiffviewOpen",
	config = function()
		local cb = require("diffview.config").diffview_callback

		require("diffview").setup({})
	end,
}
