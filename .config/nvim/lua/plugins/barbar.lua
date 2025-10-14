-- Barbar
-- https://github.com/romgrk/barbar.nvim
--
-- Tabline plugin with buffer management, icons, and auto-hide support
-- Keymaps: Alt+,/. (navigate), Alt+1-9 (goto buffer), Alt+c (close), Ctrl+p (pick)
-- Integrates with nvim-tree to adjust offset automatically

local setup = function()
	local nvim_tree_events = require("nvim-tree.events")
	local bufferline_api = require("bufferline.api")

	local function get_tree_size()
		-- in linux this require sometimes fails
		local ok, nvim_tree_view = pcall(require, "nvim-tree.view")
		if not ok then
			return 0
		end
		return nvim_tree_view.View.width
	end

	nvim_tree_events.subscribe("TreeOpen", function()
		bufferline_api.set_offset(get_tree_size())
	end)

	nvim_tree_events.subscribe("Resize", function()
		bufferline_api.set_offset(get_tree_size())
	end)

	nvim_tree_events.subscribe("TreeClose", function()
		bufferline_api.set_offset(0)
	end)

	local map = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }

	-- Move to previous/next
	map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Previous buffer" }))
	map("n", "<A-.>", "<Cmd>BufferNext<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Next buffer" }))
	-- Re-order to previous/next
	map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Move buffer left" }))
	map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Move buffer right" }))
	-- Goto buffer in position...
	map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 1" }))
	map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 2" }))
	map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 3" }))
	map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 4" }))
	map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 5" }))
	map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 6" }))
	map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 7" }))
	map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 8" }))
	map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to buffer 9" }))
	map("n", "<A-0>", "<Cmd>BufferLast<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Go to last buffer" }))
	-- Pin/unpin buffer
	map("n", "<A-p>", "<Cmd>BufferPin<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Pin/unpin buffer" }))
	-- Close buffer
	map("n", "<A-c>", "<Cmd>BufferClose<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Close buffer" }))
	-- Wipeout buffer
	--                 :BufferWipeout
	-- Close commands
	--                 :BufferCloseAllButCurrent
	--                 :BufferCloseAllButPinned
	--                 :BufferCloseAllButCurrentOrPinned
	--                 :BufferCloseBuffersLeft
	--                 :BufferCloseBuffersRight
	-- Magic buffer-picking mode
	map("n", "<C-p>", "<Cmd>BufferPick<CR>", vim.tbl_extend("force", opts, { desc = "Barbar: Pick buffer" }))
	-- Sort automatically by...
	--map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
	--map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
	--map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
	--map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

	-- Other:
	-- :BarbarEnable - enables barbar (enabled by default)
	-- :BarbarDisable - very bad command, should never be used

	vim.api.nvim_set_keymap("n", "<leader>bd", ":BufferDelete<CR>", {})
	vim.api.nvim_set_keymap("n", "<leader>bc", ":BufferClose<CR>", {})
	vim.api.nvim_set_keymap("n", "<leader>bo", ":BufferCloseAllButCurrent<CR>", {})
	vim.api.nvim_set_keymap("n", "<leader>bp", ":BufferPin<CR>", {})
	vim.api.nvim_set_keymap("n", "<leader>bn", ":BufferNext<CR>", {})
	vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", {})
	vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", {})

	require("barbar").setup({
		auto_hide = true,
	})
end

return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		setup()
	end,
}
