-- Lualine
-- https://github.com/nvim-lualine/lualine.nvim
--
-- Fast and customizable statusline with mode, branch, diagnostics, and file info
-- Uses onedark theme with custom separators
-- Shows: mode, git branch, diff, diagnostics, filename, encoding, filetype, progress, location
-- Integrates with nvim-tree and copilot

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		--'kyazdani42/nvim-web-devicons'
		"Mofiqul/vscode.nvim",
		"AndreM222/copilot-lualine",
	},
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = 'vscode',
				theme = "onedark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "nvim-tree" },
		})
	end,
}
