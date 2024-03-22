return {
	"MeanderingProgrammer/markdown.nvim",
	ft = "markdown",
	name = "render-markdown",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("render-markdown").setup({})
	end,
}
