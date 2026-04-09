vim.pack.add({
  "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
  "https://github.com/echasnovski/mini.comment",
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring()
				or vim.bo.commentstring
		end,
	},
	mappings = {
		comment_line = "gcc",
		comment      = "gc",
		textobject   = "gc",
	},
})
