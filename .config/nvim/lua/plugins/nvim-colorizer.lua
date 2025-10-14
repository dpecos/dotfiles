-- Nvim Colorizer
-- https://github.com/norcalli/nvim-colorizer.lua
--
-- Highlight color codes with their actual colors inline
-- Supports: hex (#fff, #ffffff), rgb(), rgba(), hsl(), hsla()
-- Useful for CSS, web development, and design work

return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup()
	end,
}
