M = {}

-- conform - DEPRECATED: Using native LSP formatting instead
-- Keeping non-JS/TS formatters only
M.formatters = {
	lua = { "stylua" },
	go = { "gofumpt", "goimports" },
	sh = { "shfmt" },
	rust = { "rustfmt" },
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
	
	["typescript-language-server"] = {
		lsp_server_name = "ts_ls",
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayVariableTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayVariableTypeHints = true,

					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},
	["rust-analyzer"] = {
		lsp_server_name = "rust_analyzer",
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true,
					experimental = {
						enable = true,
					},
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
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

return M
