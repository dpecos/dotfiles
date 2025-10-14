-- nvim-surround - Modern surround text objects
-- 
-- Replaces vim-surround with a native Lua implementation
-- 
-- Features:
-- • Add surrounding pairs (ys)
-- • Delete surrounding pairs (ds)
-- • Change surrounding pairs (cs)
-- • Works with motions, text objects, and visual selections
-- • Supports custom surroundings
-- • Better than vim-surround: native Lua, more features, better maintained
--
-- Basic usage:
-- • ysiw" - Surround inner word with "
-- • yss) - Surround entire line with ()
-- • ds" - Delete surrounding "
-- • cs"' - Change surrounding " to '
-- • cs({ - Change surrounding ( to { with space
-- • ySS) - Surround line with () on new lines
-- • Visual mode: S" - Surround selection with "
--
-- Text objects:
-- • iw - inner word
-- • aw - a word
-- • i" - inside quotes
-- • a" - around quotes
-- • ip - inner paragraph
-- • ap - around paragraph
-- • it - inner tag (HTML)
-- • at - around tag

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
