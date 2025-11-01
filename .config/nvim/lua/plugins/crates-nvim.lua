-- Crates.nvim
-- https://github.com/saecki/crates.nvim
--
-- Cargo.toml dependency management with inline version display, updates, and documentation links
-- Auto-loads on Cargo.toml files with keymaps under <leader>c

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
				local map = require("utils.keymap").map

				-- Version management
				map("<leader>ct", crates.toggle, "Crates", "Toggle crates UI", { buffer = event.buf })
				map("<leader>cr", crates.reload, "Crates", "Reload crates", { buffer = event.buf })

				-- Update crates
				map("<leader>cu", crates.update_crate, "Crates", "Update crate", { buffer = event.buf })
				map("<leader>cu", crates.update_crates, "Crates", "Update crates", { mode = "v", buffer = event.buf })
				map("<leader>ca", crates.update_all_crates, "Crates", "Update all crates", { buffer = event.buf })

				-- Upgrade crates
				map("<leader>cU", crates.upgrade_crate, "Crates", "Upgrade crate", { buffer = event.buf })
				map("<leader>cU", crates.upgrade_crates, "Crates", "Upgrade crates", { mode = "v", buffer = event.buf })
				map("<leader>cA", crates.upgrade_all_crates, "Crates", "Upgrade all crates", { buffer = event.buf })

				-- Documentation
				map("<leader>cd", crates.open_documentation, "Crates", "Open documentation", { buffer = event.buf })
				map("<leader>ch", crates.open_homepage, "Crates", "Open homepage", { buffer = event.buf })
				map("<leader>cp", crates.open_repository, "Crates", "Open repository", { buffer = event.buf })
				map("<leader>cC", crates.open_crates_io, "Crates", "Open crates.io", { buffer = event.buf })

				-- Version popup
				map("<leader>cv", crates.show_versions_popup, "Crates", "Show versions", { buffer = event.buf })
				map("<leader>cf", crates.show_features_popup, "Crates", "Show features", { buffer = event.buf })
				map("<leader>cD", crates.show_dependencies_popup, "Crates", "Show dependencies", { buffer = event.buf })

				-- Expansion
				map("<leader>cx", crates.expand_plain_crate_to_inline_table, "Crates", "Expand to inline table", { buffer = event.buf })
				map("<leader>cX", crates.extract_crate_into_table, "Crates", "Extract to table", { buffer = event.buf })
			end,
		})
	end,
}
