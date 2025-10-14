M = {}

-- conform - DEPRECATED: Using native LSP formatting instead
-- Keeping non-JS/TS/Rust formatters only
M.formatters = {
	lua = { "stylua" },
	go = { "gofumpt", "goimports" },
	sh = { "shfmt" },
	-- rust formatting now handled by rust-analyzer LSP
	yaml = { "yamlfmt" },
	markdown = { "markdownlint" },
	toml = { "taplo" },
	-- JS/TS/JSON/CSS now handled by Biome LSP
}

-- nvim-lint - DEPRECATED: Using Biome LSP for JS/TS
M.linters = {
	-- JS/TS now handled by Biome LSP (formatting + linting)
	sh = { "shellcheck" },
	yaml = { "yamllint" },
	markdown = { "markdownlint" },
	-- CSS handled by Biome or separate LSP
}

-- lspconfig
M.servers = {
	-- Biome - Modern fast formatter/linter for JS/TS/JSON/CSS
	biome = {
		root_dir = function(fname)
			-- Look for biome.json or biome.jsonc
			local util = require("lspconfig.util")
			return util.root_pattern("biome.json", "biome.jsonc")(fname)
				or util.find_git_ancestor(fname)
				or util.find_package_json_ancestor(fname)
		end,
		single_file_support = true,
	},
	
	-- NOTE: TypeScript/JavaScript now handled by typescript-tools.nvim
	-- See lua/plugins/typescript-tools.lua for configuration
	-- The old typescript-language-server (ts_ls) is replaced by typescript-tools
	-- which provides better performance and more features
	
	-- NOTE: rust-analyzer is NOT configured here to avoid clash with rustaceanvim
	-- See M.rust_analyzer_settings below and lua/plugins/rustaceanvim.lua
	gopls = {},
	["lua-language-server"] = {
		lsp_server_name = "lua_ls",
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					-- library = vim.api.nvim_get_runtime_file("", true),
					library = {
						vim.fn.stdpath("config"),
					},
					checkThirdParty = false,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
	["json-lsp"] = {
		lsp_server_name = "jsonls",
	},
	["yaml-language-server"] = {
		lsp_server_name = "yamlls",
		settings = {
			yaml = {
				keyOrdering = false,
			},
		},
	},
	["bash-language-server"] = {
		lsp_server_name = "bashls",
	},
	["prosemd-lsp"] = {
		lsp_server_name = "prosemd_lsp",
	},
	["terraform-ls"] = {
		lsp_server_name = "terraformls",
	},
}

-- Rust-analyzer settings (used by rustaceanvim, not lspconfig)
-- Kept separate to avoid clash - rustaceanvim manages rust-analyzer automatically
-- Based on rust-analyzer 2024+ schema
M.rust_analyzer_settings = {
	-- Enable all features by default
	cargo = {
		allFeatures = true,
		loadOutDirsFromCheck = true,
		buildScripts = {
			enable = true,
		},
	},
	-- Enable procedural macro support
	procMacro = {
		enable = true,
		ignored = {
			["async-trait"] = { "async_trait" },
			["napi-derive"] = { "napi" },
			["async-recursion"] = { "async_recursion" },
		},
	},
	-- Enhanced diagnostics
	diagnostics = {
		enable = true,
		experimental = {
			enable = true,
		},
		styleLints = {
			enable = true,
		},
	},
	-- Run clippy on save (modern schema)
	check = {
		command = "clippy",
		extraArgs = { "--all-targets" },
	},
	-- Inlay hints (modern schema - most moved to editor config)
	inlayHints = {
		bindingModeHints = {
			enable = true,
		},
		chainingHints = {
			enable = true,
		},
		closingBraceHints = {
			minLines = 25,
		},
		closureReturnTypeHints = {
			enable = "with_block",
		},
		lifetimeElisionHints = {
			enable = "skip_trivial",
			useParameterNames = true,
		},
		parameterHints = {
			enable = true,
		},
		typeHints = {
			enable = true,
			hideClosureInitialization = false,
			hideNamedConstructor = false,
		},
	},
	-- Lens
	lens = {
		enable = true,
		references = {
			adt = { enable = true },
			enumVariant = { enable = true },
			method = { enable = true },
			trait = { enable = true },
		},
	},
	-- Hover actions
	hover = {
		actions = {
			enable = true,
		},
		documentation = {
			enable = true,
		},
	},
	-- Assist
	assist = {
		importGranularity = "module",
		importPrefix = "by_crate",
	},
}

return M
