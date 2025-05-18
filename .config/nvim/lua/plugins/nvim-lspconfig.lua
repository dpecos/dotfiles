local function client_supports_method(client, method, bufnr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client:supports_method(method, bufnr)
	else
		return client.supports_method(method, { bufnr = bufnr })
	end
end

local on_lsp_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)

	for bufnr, _ in pairs(client.attached_buffers) do
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

		local function map(scope, mode, keys, func, opts)
			opts.buffer = bufnr
			opts.desc = (scope or "Unknown scope") .. ": " .. opts.desc

			vim.keymap.set(mode, keys, func, opts)
		end

		local nmap_lsp = function(keys, func, desc, opts)
			opts = opts or {}
			opts.desc = desc

			map("LSP", "n", keys, func, opts)
		end

		nmap_lsp("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap_lsp("gDv", ":vsplit | lua vim.lsp.buf.declaration()<CR>", "[G]oto [D]eclaration (vertical split)")
		nmap_lsp("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		nmap_lsp("gdv", ":vsplit | lua vim.lsp.buf.definition()<CR>", "[G]oto [D]efinition (vertical split)")
		nmap_lsp("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap_lsp("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		nmap_lsp("<leader>fd", require("telescope.builtin").lsp_definitions, "List [D]efinitions")
		nmap_lsp("<leader>ftd", require("telescope.builtin").lsp_type_definitions, "List [T]ype [D]efinitions")
		nmap_lsp("<leader>fds", require("telescope.builtin").lsp_document_symbols, "List [D]ocument [S]ymbols")
		nmap_lsp(
			"<leader>fws",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			"List [W]orkspace [S]ymbols"
		)

		nmap_lsp("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		nmap_lsp("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		nmap_lsp("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "Documentation")
		nmap_lsp("<leader>k", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, "Signature Documentation")

		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			vim.lsp.inlay_hint.enable(true) -- enable inlay hints by default

			nmap_lsp("<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay [H]ints")
		end

		-- if client.server_capabilities.documentFormattingProvider then
		--   nmap_lsp("<leader>f", function()
		--     vim.lsp.buf.format({ async = true })
		--   end, "[F]ormat current buffer (DFP)")
		-- end

		nmap_lsp("[e", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, "Previous error")
		nmap_lsp("]e", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, "Next error")
		nmap_lsp("[w", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
		end, "Previous warn")
		nmap_lsp("]w", function()
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
		end, "Next [c]hange", { expr = true })

		nmap_gs("[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, "Previous [c]hange", { expr = true })

		-- Actions
		map_gs({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "[h]unk [s]tage")
		map_gs({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "[h]unk [r]eset")
		nmap_gs("<leader>hS", gs.stage_buffer, "stage buffer")
		nmap_gs("<leader>hu", gs.undo_stage_hunk, "[h]unk [u]nstage")
		nmap_gs("<leader>hR", gs.reset_buffer, "reset buffer")
		nmap_gs("<leader>hp", gs.preview_hunk, "[h]unk [p]review")
		nmap_gs("<leader>hb", function()
			gs.blame_line({ full = true })
		end, "[h]unk [b]lame")
		nmap_gs("<leader>tb", gs.toggle_current_line_blame, "[t]oggle [b]lame for current line")
		nmap_gs("<leader>hd", gs.diffthis, "[h]unk [d]iff")
		nmap_gs("<leader>hD", function()
			gs.diffthis("~")
		end, "[h]unk [d]iff ~")
		nmap_gs("<leader>td", gs.toggle_deleted, "[t]oggle [d]eleted")
		-- Text object
		map_gs({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")

		-- End of GitSigns mappings --

		-- The following autocommands are used to highlight references of the word under your cursor when your cursor rests there for a little while.
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
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
end

local setup = function()
	-- enable diagnostic test at the EOL where the problem is
	vim.diagnostic.config({
		virtual_text = {
			prefix = "●",
			-- spacing = 0,
		},
		float = { border = "single" },
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
