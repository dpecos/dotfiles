M = {}

-- conform
M.formatters = {
	lua = { "stylua" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	graphql = { "prettier" },
	go = { "gofumpt", "goimports" },
	sh = { "shfmt" },
	rust = { "rustfmt" },
	json = { "prettier" },
	yaml = { "yamlfmt" },
	markdown = { "markdownlint" },
	toml = { "taplo" },
	html = { "prettier" },
	css = { "stylelint", "prettier" },
}

-- nvim-lint
M.linters = {
	javascript = { "oxlint" },
	typescript = { "oxlint" },
	javascriptreact = { "oxlint" },
	typescriptreact = { "oxlint" },
	-- lua = { "luacheck" },
	sh = { "shellcheck" },
	--rust = { "cargo" },
	json = { "jsonlint" },
	yaml = { "yamllint" },
	markdown = { "markdownlint" },
	css = { "stylelint" },
}

-- lspconfig
M.servers = {
	ts_ls = {
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
	rust_analyzer = {
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
	lua_ls = {
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
	jsonls = {},
	yamlls = {
		settings = {
			yaml = {
				keyOrdering = false,
			},
		},
	},
	bashls = {},
	prosemd_lsp = {},
	terraformls = {},
}

return M
