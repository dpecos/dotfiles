local setup = function()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      path_display = { "smart" },
      file_ignore_patterns = { ".git", "node_modules" },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        additional_args = function(opts)
          return { "--hidden" }
        end,
      },
    },
  })

  -- Enable telescope fzf native, if installed
  -- pcall(telescope.load_extension, 'fzf')
  -- telescope.load_extension('fzf')

  -- See `:help telescope.builtin`
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recently opened files" })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find existing buffers" })
  vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, { desc = "[/] Fuzzily search in current buffer" })

  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search Help" })
  vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search current Word" })
  vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Search by Grep" })
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search Diagnostics" })
  vim.keymap.set("n", "<leader>fx", builtin.resume, { desc = "Resume" })

  vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search Keymaps" })
  vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Search LSP references" })
  vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Search Marks" })

  vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
  vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "Git commits" })
  vim.keymap.set("n", "<leader>gh", builtin.git_bcommits, { desc = "Git commits in current branch" })
  vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
end

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  event = "VeryLazy",
  config = function()
    setup()
  end,
}
