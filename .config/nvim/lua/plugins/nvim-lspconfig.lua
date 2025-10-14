-- LSP Configuration using Neovim native features
-- 
-- Native features being used (available in Neovim 0.10+/0.11+):
-- ✓ vim.lsp.config/enable (0.11+) - Native LSP server configuration
-- ✓ vim.diagnostic.config (0.10+) - Native diagnostic configuration  
-- ✓ vim.lsp.inlay_hint (0.10+) - Native inlay hints
-- ✓ vim.snippet (0.10+) - Native snippet support
-- ✓ vim.lsp.completion (0.11+) - Native LSP completion (nvim-cmp removed)
-- ✓ vim.lsp.buf.format (0.8+) - Native LSP formatting (conform.nvim removed)
-- ✓ vim.bo (0.10+) - Modern buffer option setting
-- ✓ Native document highlight - No plugin needed
--
-- Plugin dependencies:
-- • nvim-lspconfig: Provides sensible defaults for LSP server configs
-- • fidget.nvim: LSP progress notifications (no native alternative)
-- • gitsigns.nvim: Git integration (no native alternative)
--
-- Formatting & Linting:
-- • Biome LSP - Handles JS/TS/JSON/CSS formatting and linting
-- • Native format-on-save using vim.lsp.buf.format()
-- • conform.nvim REMOVED - using native LSP formatting
-- • nvim-lint REMOVED - using LSP diagnostics (Biome for JS/TS)
--
-- This configuration uses:
-- • ONLY native completion (nvim-cmp removed)
-- • ONLY native formatting (conform.nvim removed)
-- • ONLY LSP diagnostics (nvim-lint removed for JS/TS)

-- Using native vim.lsp.supports_method (0.11+) instead of custom wrapper
local function client_supports_method(client, method, bufnr)
	return client:supports_method(method, { bufnr = bufnr })
end

local on_lsp_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)

	-- Enable completion triggered by <c-x><c-o>
	-- Using vim.bo instead of deprecated vim.api.nvim_buf_set_option
	vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	vim.bo[event.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"
	
	-- Enable native LSP completion (Neovim 0.11+)
	-- Using native completion exclusively (nvim-cmp removed)
	if vim.fn.has("nvim-0.11") == 1 then
		vim.lsp.completion.enable(true, client.id, event.buf, { 
			autotrigger = true,
			-- Convert LSP completion items to Vim completion items
			convert = function(item)
				-- Customize completion item conversion if needed
				return item
			end,
		})
	end

	-- Setup snippet expansion using native vim.snippet (Neovim 0.10+)
	-- This replaces the need for snippet plugins like vsnip or luasnip

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

	-- Organize imports (for TypeScript/JavaScript)
	map_lsp("<leader>o", function()
		vim.lsp.buf.code_action({
			context = {
				only = { "source.organizeImports" },
				diagnostics = {},
			},
			apply = true,
		})
	end, "Organize imports")

	map_lsp("K", function()
		vim.lsp.buf.hover({ border = "rounded" })
	end, "Documentation")
	map_lsp("<leader>k", function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end, "Signature Documentation")

	-- Native snippet navigation (Neovim 0.10+)
	-- Jump forward/backward in snippets - replaces vsnip keymaps
	vim.keymap.set({ "i", "s" }, "<C-f>", function()
		if vim.snippet.active({ direction = 1 }) then
			return vim.snippet.jump(1)
		end
	end, { buffer = event.buf, expr = true, desc = "Snippet: Jump forward" })
	
	vim.keymap.set({ "i", "s" }, "<C-b>", function()
		if vim.snippet.active({ direction = -1 }) then
			return vim.snippet.jump(-1)
		end
	end, { buffer = event.buf, expr = true, desc = "Snippet: Jump backward" })

	-- Native LSP Formatting (replaces conform.nvim)
	-- Format on save using LSP's native formatting capability
	if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_formatting, event.buf) then
		-- Manual format keymap
		map_lsp("<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "Format buffer")

		-- Format on save (can be disabled per buffer or globally)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = event.buf,
			callback = function()
				-- Skip if formatting is disabled
				if vim.g.disable_autoformat or vim.b[event.buf].disable_autoformat then
					return
				end
				
				-- Skip node_modules
				local bufname = vim.api.nvim_buf_get_name(event.buf)
				if bufname:match("/node_modules/") then
					return
				end
				
				-- Organize imports for TypeScript/JavaScript files (via Biome or ts_ls)
				local filetype = vim.bo[event.buf].filetype
				if filetype == "typescript" or filetype == "typescriptreact" 
					or filetype == "javascript" or filetype == "javascriptreact" then
					
					-- Try to organize imports (Biome and TypeScript LSP both support this)
					pcall(function()
						vim.lsp.buf.code_action({
							context = {
								only = { "source.organizeImports" },
								diagnostics = {},
							},
							apply = true,
						})
					end)
					
					-- Small delay to let organize imports complete before formatting
					vim.defer_fn(function()
						-- Format synchronously before save
						vim.lsp.buf.format({ 
							async = false,
							timeout_ms = 1000,
							bufnr = event.buf,
						})
					end, 100)
				else
					-- For non-JS/TS files, just format
					vim.lsp.buf.format({ 
						async = false,
						timeout_ms = 1000,
						bufnr = event.buf,
					})
				end
			end,
		})
	end

	if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
		vim.lsp.inlay_hint.enable(true, { bufnr = event.buf }) -- enable inlay hints by default with buffer parameter

		map_lsp("<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
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
	-- Native diagnostic configuration (Neovim 0.10+)
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
		-- Native sign configuration (Neovim 0.10+)
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

	-- Native LSP setup using vim.lsp.config and vim.lsp.enable (Neovim 0.11+)
	-- This replaces the need for nvim-lspconfig plugin setup
	local mason_tools = require("plugins/local/mason-tools")
	for server, config in pairs(mason_tools.servers) do
		local lsp_server_name = config.lsp_server_name or server
		config.lsp_server_name = nil

		vim.lsp.config(lsp_server_name, config)
		vim.lsp.enable(lsp_server_name)
	end

	-- Native LspAttach autocmd (Neovim 0.8+)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = on_lsp_attach,
	})

	-- Commands to enable/disable auto-formatting (replaces conform commands)
	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			-- FormatDisable! will disable formatting just for this buffer
			vim.b.disable_autoformat = true
		else
			vim.g.disable_autoformat = true
		end
		print("Auto-formatting disabled" .. (args.bang and " (buffer)" or " (global)"))
	end, {
		desc = "Disable LSP format-on-save",
		bang = true,
	})

	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
		print("Auto-formatting enabled")
	end, {
		desc = "Re-enable LSP format-on-save",
	})

	vim.api.nvim_create_user_command("Format", function()
		vim.lsp.buf.format({ async = false })
	end, {
		desc = "Format current buffer using LSP",
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
