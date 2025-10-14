-- Mini.comment - Modern commenting plugin
-- 
-- Features:
-- • Respects commentstring from treesitter
-- • Works with multiline selections
-- • Handles edge cases well
-- • Lightweight and fast
--
-- Default keymaps:
-- • gcc - Toggle comment for line
-- • gc - Toggle comment for motion/visual selection
-- • gbc - Toggle block comment for line
-- • gb - Toggle block comment for motion/visual

return {
	"echasnovski/mini.comment",
	event = "VeryLazy",
	opts = {
		options = {
			-- Use treesitter for getting correct commentstring
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
			end,
		},
		mappings = {
			-- Toggle comment on current line
			comment_line = "gcc",
			-- Toggle comment on visual selection
			comment = "gc",
			-- Define 'comment' textobject (for "gcip" - comment inner paragraph)
			textobject = "gc",
		},
	},
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = {
				enable_autocmd = false,
			},
		},
	},
}
