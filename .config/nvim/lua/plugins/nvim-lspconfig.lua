local function client_supports_method(client, method, bufnr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client:supports_method(method, bufnr)
	else
		return client.supports_method(method, { bufnr = bufnr })
	end
end

local on_lsp_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(event.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(event.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	local function map(scope, mode, keys, func, opts)
		opts.buffer = event.buf
		opts.desc = (scope or "Unknown scope") .. ": " .. opts.desc

		vim.keymap.set(mode, keys, func, opts)
	end

	local map_lsp = function(keys, func, desc, opts)
		opts = opts or {}
		opts.desc = desc

		map("LSP", "n", keys, func, opts)
	end

	map_lsp("gD", vim.lsp.buf.declaration, "Goto Declaration")
	map_lsp("gDv", ":vsplit | lua vim.lsp.buf.declaration()<CR>", "Goto Declaration (vertical split)")
	map_lsp("gd", vim.lsp.buf.definition, "Goto Definition")
	map_lsp("gdv", ":vsplit | lua vim.lsp.buf.definition()<CR>", "Goto Definition (vertical split)")
	map_lsp("grr", require("telescope.builtin").lsp_references, "List References")
	map_lsp("gri", require("telescope.builtin").lsp_implementations, "List Implementation")
	-- nmap_lsp("gld", require("telescope.builtin").lsp_definitions, "List Definitions")
	-- nmap_lsp("gltd", require("telescope.builtin").lsp_type_definitions, "List Type Definitions")
	map_lsp("gO", require("telescope.builtin").lsp_document_symbols, "List Document Symbols")
	map_lsp("grn", vim.lsp.buf.rename, "Rename")
	map_lsp("gra", vim.lsp.buf.code_action, "Code Action")

	map_lsp("K", function()
		vim.lsp.buf.hover({ border = "rounded" })
	end, "Documentation")
	map_lsp("<leader>k", function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end, "Signature Documentation")

	if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
		vim.lsp.inlay_hint.enable(true) -- enable inlay hints by default

		map_lsp("<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end, "Toggle inlay Hints")
	end

	-- if client.server_capabilities.documentFormattingProvider then
	--   nmap_lsp("<leader>f", function()
	--     vim.lsp.buf.format({ async = true })
	--   end, "[F]ormat current buffer (DFP)")
	-- end

	map_lsp("[e", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, "Previous error")
	map_lsp("]e", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, "Next error")
	map_lsp("[w", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	end, "Previous warn")
	map_lsp("]w", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	end, "Next warn")

	-- GitSigns mappings --
	local map_gs = function(mode, keys, func, desc, opts)
		opts = opts or {}
		opts.desc = desc

		map("GitSigns", "n", keys, func, opts)
	end

	local nmap_gs = function(keys, func, desc, opts)
		map_gs("n", keys, func, desc, opts)
	end

	local gs = package.loaded.gitsigns

	-- Navigation
	nmap_gs("]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, "Next change", { expr = true })

	nmap_gs("[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, "Previous change", { expr = true })

	-- Actions
	map_gs({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "hunk stage")
	map_gs({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "hunk reset")
	nmap_gs("<leader>hS", gs.stage_buffer, "stage buffer")
	nmap_gs("<leader>hu", gs.undo_stage_hunk, "hunk unstage")
	nmap_gs("<leader>hR", gs.reset_buffer, "reset buffer")
	nmap_gs("<leader>hp", gs.preview_hunk, "hunk preview")
	nmap_gs("<leader>hb", function()
		gs.blame_line({ full = true })
	end, "hunk blame")
	nmap_gs("<leader>tb", gs.toggle_current_line_blame, "toggle blame for current line")
	nmap_gs("<leader>hd", gs.diffthis, "hunk diff")
	nmap_gs("<leader>hD", function()
		gs.diffthis("~")
	end, "hunk diff ~")
	nmap_gs("<leader>td", gs.toggle_deleted, "toggle deleted")
	-- Text object
	map_gs({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")

	-- End of GitSigns mappings --

	-- The following autocommands are used to highlight references of the word under your cursor when your cursor rests there for a little while.
	if
		client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
	then
		local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

local setup = function()
	vim.diagnostic.config({
		virtual_lines = true,
		-- virtual_text = {
		-- 	prefix = "●",
		-- 	-- spacing = 0,
		-- },
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "single",
			source = true,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "󰅚 ",
				[vim.diagnostic.severity.WARN] = "󰀪 ",
				[vim.diagnostic.severity.INFO] = "󰋽 ",
				[vim.diagnostic.severity.HINT] = "󰌶 ",
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "ErrorMsg",
				[vim.diagnostic.severity.WARN] = "WarningMsg",
			},
		},
	})

	-- LSP setup
	local mason_tools = require("plugins/local/mason-tools")
	for server, config in pairs(mason_tools.servers) do
		local lsp_server_name = config.lsp_server_name or server
		config.lsp_server_name = nil

		vim.lsp.config(lsp_server_name, config)
		vim.lsp.enable(lsp_server_name)
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = on_lsp_attach,
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"neovim/nvim-lspconfig",

		-- Useful status updates for LSP
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0, -- transparent
					},
				},
				integration = {
					["nvim-tree"] = {
						enable = true,
					},
				},
			},
		},

		"lewis6991/gitsigns.nvim",
	},
	config = function()
		setup()
	end,
}
