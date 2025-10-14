-- Nvim Tree
-- https://github.com/nvim-tree/nvim-tree.lua
--
-- File explorer tree with git integration, icons, and auto-sync across tabs
-- Keymaps: Ctrl+n (toggle), <leader>n (find file), <leader>r (refresh)
-- Custom keybindings: v (vsplit), h (hsplit), a (create), d (delete), r (rename)
-- Auto-opens when starting Neovim without a file and closes when last buffer

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "h", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))

	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "gy", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "gY", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))

	vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

local setup = function()
	require("nvim-tree").setup({
		hijack_cursor = true,
		view = {
			width = 50,
		},
		tab = {
			sync = {
				open = true,
				close = true,
			},
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = false,
			custom = { "\\.git$", "node_modules" },
		},
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		actions = {
			use_system_clipboard = true,
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
		git = {
			enable = true,
			ignore = false,
		},
		on_attach = on_attach,
	})

	local api = require("nvim-tree.api")

	vim.keymap.set("n", "<C-n>", api.tree.toggle, { desc = "NvimTree: Toggle file explorer" })
	vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "NvimTree: Refresh file explorer" })
	vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { desc = "NvimTree: Show current file in explorer" })

	-- close vim if nvim-tree is the last buffer
	local function tab_win_closed(winnr)
		local api = require("nvim-tree.api")
		local tabnr = vim.api.nvim_win_get_tabpage(winnr)
		local bufnr = vim.api.nvim_win_get_buf(winnr)
		local buf_info = vim.fn.getbufinfo(bufnr)[1]
		local tab_wins = vim.tbl_filter(function(w)
			return w ~= winnr
		end, vim.api.nvim_tabpage_list_wins(tabnr))
		local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
		if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
			-- Close all nvim tree on :q
			if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
				api.tree.close()
			end
		else -- else closed buffer was normal buffer
			if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
				local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
				if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
					vim.schedule(function()
						if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
							vim.cmd("quit") -- then close all of vim
						else -- else there are more tabs open
							vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
						end
					end)
				end
			end
		end
	end

	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function(data)
			local IGNORED_FT = {
				"gitcommit",
			}

			-- buffer is a real file on the disk
			local real_file = vim.fn.filereadable(data.file) == 1

			-- buffer is a [No Name]
			local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

			-- &ft
			local filetype = vim.bo[data.buf].ft

			-- real files do not open the tree
			if real_file or not no_name then
				return
			end

			-- skip ignored filetypes
			if vim.tbl_contains(IGNORED_FT, filetype) then
				return
			end

			-- open the tree but don't focus it
			require("nvim-tree.api").tree.toggle({ focus = false })
		end,
	})

	vim.api.nvim_create_autocmd("WinClosed", {
		callback = function()
			local winnr = tonumber(vim.fn.expand("<amatch>"))
			vim.schedule_wrap(tab_win_closed(winnr))
		end,
		nested = true,
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = true,
	config = function()
		setup()
	end,
}
