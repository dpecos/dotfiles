-- Nvim Surround
-- https://github.com/kylechui/nvim-surround
--
-- Add, delete, and change surrounding pairs (quotes, brackets, tags, etc.)
-- Keymaps: ys (add), ds (delete), cs (change), S (visual mode)
-- Examples: ysiw", ds", cs"', yss)

return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Default keymaps:
			-- ys{motion}{char} - Add surround
			-- ds{char} - Delete surround
			-- cs{target}{replacement} - Change surround
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
			-- Custom surroundings can be added here
			surrounds = {
				-- Example: Add custom markdown link surround
				-- ["l"] = {
				-- 	add = function()
				-- 		local clipboard = vim.fn.getreg("+"):gsub("\n", "")
				-- 		return {
				-- 			{ "[" },
				-- 			{ "](" .. clipboard .. ")" },
				-- 		}
				-- 	end,
				-- },
			},
			-- Enable/disable default surrounds
			-- e.g., to disable ( and ) surrounds: ["("] = false, [")"] = false
			aliases = {
				["a"] = ">", -- HTML tag
				["b"] = ")", -- Parentheses
				["B"] = "}", -- Braces
				["r"] = "]", -- Brackets
				["q"] = { '"', "'", "`" }, -- Quotes
				["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- All surrounding pairs
			},
			highlight = {
				duration = 0,
			},
			move_cursor = "begin",
		})
	end,
}
