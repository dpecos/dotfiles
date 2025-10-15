-- Nvim Web Devicons
-- https://github.com/nvim-tree/nvim-web-devicons
--
-- File type icons with colors for file explorers and pickers
-- Provides colored icons for different file types in nvim-tree, telescope, etc.

return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			-- globally enable different highlight colors per icon (default to true)
			color_icons = true,
			-- globally enable default icons (default to false)
			default = true,
			-- globally enable "strict" selection of icons - icon will be looked up in
			-- different tables, first by filename, and if not found by extension
			strict = true,
		})
	end,
}
