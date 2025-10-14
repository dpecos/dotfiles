-- Modern TypeScript/JavaScript tooling using typescript-tools.nvim
-- 
-- This plugin provides enhanced TypeScript support beyond standard ts_ls:
-- ✓ Better performance and startup time
-- ✓ Organize imports command
-- ✓ Add missing imports
-- ✓ Remove unused imports
-- ✓ Fix all fixable errors
-- ✓ Better inlay hints
-- ✓ File references
-- ✓ Better rename support
--
-- Replaces: typescript-language-server (ts_ls)
-- Works with: Biome for formatting/linting

return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	opts = {
		on_attach = function(client, bufnr)
			-- Disable formatting - let Biome handle it
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false

			-- TypeScript-specific keymaps
			local map = function(mode, keys, func, desc)
				vim.keymap.set(mode, keys, func, {
					buffer = bufnr,
					desc = "TS Tools: " .. desc,
					silent = true,
				})
			end

			-- Organize imports (enhanced version)
			map("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", "Organize imports")
			
			-- Sort imports (separate from organize)
			map("n", "<leader>os", "<cmd>TSToolsSortImports<cr>", "Sort imports")
			
			-- Remove unused imports
			map("n", "<leader>ou", "<cmd>TSToolsRemoveUnusedImports<cr>", "Remove unused imports")
			
			-- Add missing imports
			map("n", "<leader>oa", "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports")
			
			-- Fix all fixable errors
			map("n", "<leader>of", "<cmd>TSToolsFixAll<cr>", "Fix all")
			
			-- Go to source definition (useful for .d.ts files)
			map("n", "gds", "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to source definition")
			
			-- File references (show all files importing this file)
			map("n", "grf", "<cmd>TSToolsFileReferences<cr>", "File references")
			
			-- Rename file and update imports
			map("n", "<leader>rf", "<cmd>TSToolsRenameFile<cr>", "Rename file & update imports")
		end,
		settings = {
			-- Spawn additional tsserver instance to calculate diagnostics on it
			separate_diagnostic_server = true,
			
			-- "change"|"insert_leave" determine when the client asks the server about diagnostic
			publish_diagnostic_on = "insert_leave",
			
			-- Enable/disable inlay hints (managed by Neovim native hints)
			expose_as_code_action = "all",
			
			-- TypeScript server settings
			tsserver_file_preferences = {
				-- Inlay hints
				includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayVariableTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				
				-- Import preferences
				includeCompletionsForModuleExports = true,
				includeCompletionsWithInsertText = true,
				
				-- Auto-import preferences  
				includeCompletionsForImportStatements = true,
				includeAutomaticOptionalChainCompletions = true,
				
				-- Organize imports
				organizeImportsIgnoreCase = false,
				organizeImportsCollation = "ordinal",
				organizeImportsCollationLocale = "en",
				organizeImportsNumericCollation = false,
				organizeImportsAccentCollation = true,
				
				-- Import module specifier
				importModuleSpecifierPreference = "shortest", -- "shortest" | "project-relative" | "relative" | "non-relative"
				importModuleSpecifierEnding = "auto", -- "auto" | "minimal" | "index" | "js"
				
				-- Quote style
				quotePreference = "auto", -- "auto" | "double" | "single"
			},
			
			-- Additional tsserver configuration
			tsserver_plugins = {
				-- Add TypeScript plugins here if needed
				-- e.g., "@styled/typescript-styled-plugin"
			},
			
			-- Specify a list of plugins to load
			tsserver_max_memory = "auto", -- Set max memory for tsserver
			
			-- Enable/disable certain features
			complete_function_calls = true,
			include_completions_with_insert_text = true,
			
			-- Code lens
			code_lens = "off", -- "off" | "all" | "implementations" | "references"
			
			-- Disable certain features for performance
			disable_member_code_lens = true,
			
			-- JSX close tag
			jsx_close_tag = {
				enable = false,
				filetypes = { "javascriptreact", "typescriptreact" },
			},
		},
	},
}
