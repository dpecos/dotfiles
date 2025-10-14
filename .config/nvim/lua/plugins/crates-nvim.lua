-- Crates.nvim - Cargo.toml dependency management
-- 
-- Features:
-- • Shows available versions inline
-- • Update dependencies
-- • Check for outdated crates
-- • Jump to documentation
-- • Completion for crate names and versions

return {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local crates = require("crates")
		crates.setup({
			-- Popup settings
			popup = {
				autofocus = true,
				border = "rounded",
				show_version_date = true,
				max_height = 30,
				min_width = 20,
			},
			-- Virtual text for inline version display
			text = {
				loading = "  Loading...",
				version = "  %s",
				prerelease = "  %s",
				yanked = "  %s yanked",
				nomatch = "  Not found",
				upgrade = "  %s",
				error = "  Error fetching crate",
			},
			-- Highlight groups
			highlight = {
				loading = "CratesNvimLoading",
				version = "CratesNvimVersion",
				prerelease = "CratesNvimPreRelease",
				yanked = "CratesNvimYanked",
				nomatch = "CratesNvimNoMatch",
				upgrade = "CratesNvimUpgrade",
				error = "CratesNvimError",
			},
			-- Enable null-ls integration for diagnostics
			null_ls = {
				enabled = false, -- We're using native LSP diagnostics
				name = "crates.nvim",
			},
		})

		-- Keymaps for Cargo.toml files
		vim.api.nvim_create_autocmd("BufRead", {
			pattern = "Cargo.toml",
			callback = function(event)
				local function map(mode, keys, func, desc)
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "Crates: " .. desc })
				end

				-- Version management
				map("n", "<leader>ct", crates.toggle, "Toggle crates UI")
				map("n", "<leader>cr", crates.reload, "Reload crates")

				-- Update crates
				map("n", "<leader>cu", crates.update_crate, "Update crate")
				map("v", "<leader>cu", crates.update_crates, "Update crates")
				map("n", "<leader>ca", crates.update_all_crates, "Update all crates")

				-- Upgrade crates
				map("n", "<leader>cU", crates.upgrade_crate, "Upgrade crate")
				map("v", "<leader>cU", crates.upgrade_crates, "Upgrade crates")
				map("n", "<leader>cA", crates.upgrade_all_crates, "Upgrade all crates")

				-- Documentation
				map("n", "<leader>cd", crates.open_documentation, "Open documentation")
				map("n", "<leader>ch", crates.open_homepage, "Open homepage")
				map("n", "<leader>cp", crates.open_repository, "Open repository")
				map("n", "<leader>cC", crates.open_crates_io, "Open crates.io")

				-- Version popup
				map("n", "<leader>cv", crates.show_versions_popup, "Show versions")
				map("n", "<leader>cf", crates.show_features_popup, "Show features")
				map("n", "<leader>cD", crates.show_dependencies_popup, "Show dependencies")

				-- Expansion
				map("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, "Expand to inline table")
				map("n", "<leader>cX", crates.extract_crate_into_table, "Extract to table")
			end,
		})
	end,
}
