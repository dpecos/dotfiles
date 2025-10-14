-- Mini Comment
-- https://github.com/echasnovski/mini.comment
--
-- Modern commenting plugin with Treesitter support
-- Keymaps: gcc (line), gc (motion/visual), gbc (block line), gb (block motion/visual)

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
