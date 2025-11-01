-- Telescope
-- https://github.com/nvim-telescope/telescope.nvim
--
-- Fuzzy finder for files, grep, buffers, git, and more with preview support
-- Keymaps: <leader>ff (files), <leader>fs (live grep), <leader>fb (buffers), <leader>fh (help)
-- Includes hidden files and custom history navigation with Ctrl+p/o

local setup = function()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules", "dist" },
      mappings = {
        i = {
          ["<C-p>"] = require("telescope.actions").cycle_history_next,
          ["<C-o>"] = require("telescope.actions").cycle_history_prev,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        additional_args = function(opts)
          return { "--hidden", "--smart-case" }
        end,
      },
    },
  })

  -- See `:help telescope.builtin`
  local builtin = require("telescope.builtin")
  local map = require("utils.keymap").map

  map("<leader>?", builtin.oldfiles, "Telescope", "Find recently opened files")
  map("<leader>fb", builtin.buffers, "Telescope", "Find existing buffers")
  map("<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, "Telescope", "Fuzzy search in current buffer")

  map("<leader>ff", builtin.find_files, "Telescope", "Find files")
  map("<leader>fh", builtin.help_tags, "Telescope", "Search help")
  map("<leader>fw", builtin.grep_string, "Telescope", "Search current word")
  map("<leader>fs", builtin.live_grep, "Telescope", "Live grep")
  map("<leader>fg", builtin.grep_string, "Telescope", "Search word under cursor")
  map("<leader>fD", builtin.diagnostics, "Telescope", "Search diagnostics")
  map("<leader>fx", builtin.resume, "Telescope", "Resume last search")

  map("<leader>fk", builtin.keymaps, "Telescope", "Search keymaps")
  map("<leader>fm", builtin.marks, "Telescope", "Search marks")

  map("<leader>gs", builtin.git_status, "Telescope", "Git status")
  map("<leader>gl", builtin.git_commits, "Telescope", "Git commits")
  map("<leader>gh", builtin.git_bcommits, "Telescope", "Git commits (current buffer)")
  map("<leader>gb", builtin.git_branches, "Telescope", "Git branches")
end

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  config = function()
    setup()
  end,
}
