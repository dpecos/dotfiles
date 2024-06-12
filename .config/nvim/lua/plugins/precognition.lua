vim.keymap.set("n", "<leader>pt", function()
	require("precognition").toggle()
end, { desc = "[p]recognition [t]oggle", silent = true })

return {
	"tris203/precognition.nvim",
	event = "VeryLazy",
	config = {
		startVisible = true,
	},
}
