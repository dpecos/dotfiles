-- Nvim Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
--
-- Advanced syntax highlighting, indentation, and text objects using treesitter parsers
-- Supports: Rust, JS/TS/TSX, Lua, Markdown, JSON, HTML, CSS, YAML, Bash, and more
-- Text objects: af/if (function), ac/ic (class), ab/ib (block), ai/ii (call)
-- Incremental selection: gnn (init), grn (expand), grm (shrink)
-- Includes nvim-treesitter-textobjects for advanced code navigation

local setup_treesitter = function()
	require("nvim-treesitter.configs").setup({
		-- A list of parser names, or "all"
		-- Updated with modern JS/TS parsers including React/JSX support
		ensure_installed = {
			"vimdoc",
			"lua",
			"vim",
			"rust",
			"markdown",
			"markdown_inline",
			-- JavaScript/TypeScript ecosystem
			"javascript",
			"typescript",
			"tsx", -- TypeScript JSX (React)
			"jsdoc", -- JSDoc comments
			"json",
			"jsonc", -- JSON with comments
			"html",
			"css",
			"scss",
			-- Other useful parsers
			"bash",
			"regex",
			"toml",
			"yaml",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			-- `false` will disable the whole extension
			enable = true,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		-- Enhanced indentation for TS/JS
		indent = {
			enable = true,
			-- Disable for languages that have issues
			disable = {},
		},

		-- Incremental selection based on treesitter
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
	})
	-- pcall(require('nvim-treesitter.install').update { with_sync = true })
end

local setup_treesitter_textobjects = function()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["ai"] = "@call.outer",
					["ii"] = "@call.inner",
				},
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true of false
				include_surrounding_whitespace = true,
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = { query = "@class.outer", desc = "Next class start" },
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			lsp_interop = {
				enable = true,
				border = "none",
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dF"] = "@class.outer",
				},
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		setup_treesitter()
		setup_treesitter_textobjects()
	end,
}
