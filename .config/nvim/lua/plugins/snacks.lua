return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "MaximilianLloyd/ascii.nvim"
  },
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    --
    -- bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        --         header = [[
        -- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        -- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        -- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        -- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        -- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        -- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = 'header' },
        {
          section = "keys",
          indent = 1,
          padding = 2,
          gap = 1,
        },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 2 },
        { section = "projects", icon = " ", title = "Projects", indent = 3, padding = 2 },
        { section = "startup" },

      },
    },
    explorer = {
      enabled = true,
      trash = false,
      follow_file = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      auto_close = true,
      win = {
        list = {
          keys = {
            -- ["v"] = "edit_vsplit",
            -- ["s"] = "edit_split",
          }
        },

      },
      sources = {
        explorer = {
          auto_close = true,
          win = {
            list = {
              keys = {
                -- ["v"] = "edit_vsplit",
                -- ["s"] = "edit_split",
              }
            }
          }
        }
      }

    },
    notifier = { enabled = true, timeout = 5000 },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true }, -- smooth scrolling
    statuscolumn = { enabled = true },
    words = { enabled = true }, -- auto-show LSP references and quickly navigate between them
    zen = {
      enabled = true,
      toggles = {
        ufo             = true,
        dim             = true,
        git_signs       = false,
        diagnostics     = false,
        line_number     = false,
        relative_number = false,
        signcolumn      = "no",
        indent          = false
      }
    },
  },
  config = function(_, opts)
    -- before initialize snacks, set a random ascii art header
    local logo = require("ascii").get_random("text", "neovim")
    for i, line in ipairs(logo) do
      opts.dashboard.preset.header = (opts.dashboard.preset.header or "") .. line .. "\n"
    end

    require("snacks").setup(opts)

    Snacks.toggle.new({
      id = "ufo",
      name = "Enable/Disable ufo",
      get = function()
        return require("ufo").inspect()
      end,
      set = function(state)
        if state == nil then
          -- require("noice").enable()
          require("ufo").enable()
          vim.o.foldenable = true
          vim.o.foldcolumn = "1"
        else
          -- require("noice").disable()
          require("ufo").disable()
          vim.o.foldenable = false
          vim.o.foldcolumn = "0"
        end
      end,
    })

    local map = require("utils.keymap").map

    -- Top Pickers & Explorer
    map("<leader><space>", function() Snacks.picker.smart() end, "Snacks", "Smart Find Files")
    -- { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    map("<leader>/", function() Snacks.picker.grep() end, "Snacks", "Grep")
    map("<leader>:", function() Snacks.picker.command_history() end, "Snacks", "Command History")
    map("<leader>n", function() Snacks.picker.notifications() end, "Snacks", "Notification History")
    -- map({ "<leader>e", "<C-n>" }, function() Snacks.explorer() end, "Snacks", "File Explorer")
    map('<leader>e',
      function()
        local explorer_win = nil

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == 'snacks_picker_list' then
            explorer_win = win
            break
          end
        end

        if vim.api.nvim_get_current_win() ~= explorer_win and explorer_win then
          vim.api.nvim_set_current_win(explorer_win)
        else
          Snacks.explorer()
        end
      end,
      "Snacks",
      'File Explorer'
    )

    -- find
    map("<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Snacks",
      "Find Config File")
    map("<leader>ff", function() Snacks.picker.files() end, "Snacks", "Find Files")
    map("<leader>fg", function() Snacks.picker.git_files() end, "Snacks", "Find Git Files")
    map("<leader>fp", function() Snacks.picker.projects() end, "Snacks", "Projects")
    map("<leader>fr", function() Snacks.picker.recent() end, "Snacks", "Recent")

    -- git
    map("<leader>gb", function() Snacks.picker.git_branches() end, "Snacks", "Git Branches")
    map("<leader>gl", function() Snacks.picker.git_log() end, "Snacks", "Git Log")
    map("<leader>gL", function() Snacks.picker.git_log_line() end, "Snacks", "Git Log Line")
    map("<leader>gs", function() Snacks.picker.git_status() end, "Snacks", "Git Status")
    map("<leader>gS", function() Snacks.picker.git_stash() end, "Snacks", "Git Stash")
    map("<leader>gd", function() Snacks.picker.git_diff() end, "Snacks", "Git Diff (Hunks)")
    map("<leader>gf", function() Snacks.picker.git_log_file() end, "Snacks", "Git Log File")

    -- gh
    map("<leader>gi", function() Snacks.picker.gh_issue() end, "Snacks", "GitHub Issues (open)")
    map("<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, "Snacks", "GitHub Issues (all)")
    map("<leader>gp", function() Snacks.picker.gh_pr() end, "Snacks", "GitHub Pull Requests (open)")
    map("<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, "Snacks", "GitHub Pull Requests (all)")

    -- Grep
    map("<leader>sb", function() Snacks.picker.lines() end, "Snacks", "Buffer Lines")
    map("<leader>sB", function() Snacks.picker.grep_buffers() end, "Snacks", "Grep Open Buffers")
    map("<leader>sg", function() Snacks.picker.grep() end, "Snacks", "Grep")
    map("<leader>sw", function() Snacks.picker.grep_word() end, "Snacks", "Visual selection or word",
      { mode = { "n", "x" } })

    -- search
    map('<leader>s"', function() Snacks.picker.registers() end, "Snacks", "Registers")
    map('<leader>s/', function() Snacks.picker.search_history() end, "Snacks", "Search History")
    map("<leader>sa", function() Snacks.picker.autocmds() end, "Snacks", "Autocmds")
    map("<leader>sc", function() Snacks.picker.command_history() end, "Snacks", "Command History")
    map("<leader>sC", function() Snacks.picker.commands() end, "Snacks", "Commands")
    map("<leader>sd", function() Snacks.picker.diagnostics() end, "Snacks", "Diagnostics")
    map("<leader>sD", function() Snacks.picker.diagnostics_buffer() end, "Snacks", "Buffer Diagnostics")
    map("<leader>sh", function() Snacks.picker.help() end, "Snacks", "Help Pages")
    map("<leader>sH", function() Snacks.picker.highlights() end, "Snacks", "Highlights")
    map("<leader>si", function() Snacks.picker.icons() end, "Snacks", "Icons")
    map("<leader>sj", function() Snacks.picker.jumps() end, "Snacks", "Jumps")
    map("<leader>sk", function() Snacks.picker.keymaps() end, "Snacks", "Keymaps")
    map("<leader>sl", function() Snacks.picker.loclist() end, "Snacks", "Location List")
    map("<leader>sm", function() Snacks.picker.marks() end, "Snacks", "Marks")
    map("<leader>sM", function() Snacks.picker.man() end, "Snacks", "Man Pages")
    map("<leader>sp", function() Snacks.picker.lazy() end, "Snacks", "Search for Plugin Spec")
    map("<leader>sq", function() Snacks.picker.qflist() end, "Snacks", "Quickfix List")
    map("<leader>sR", function() Snacks.picker.resume() end, "Snacks", "Resume")
    map("<leader>su", function() Snacks.picker.undo() end, "Snacks", "Undo History")
    map("<leader>uC", function() Snacks.picker.colorschemes() end, "Snacks", "Colorschemes")

    -- buffers
    map({ "<leader>fb", "<leader>bb" }, function() Snacks.picker.buffers() end, "Buffers", "Buffers")
    map("<leader>bd", function() Snacks.bufdelete() end, "Buffers", "Delete Buffer")
    map("<leader>ba", function() Snacks.bufdelete.all() end, "Buffers", "Delete All Buffers")
    map("<leader>bo", function() Snacks.bufdelete.other() end, "Buffers", "Delete Other Buffers")
    map({ "<leader>bn", "<Tab>" }, ":bnext<CR>", "Buffers", "Next Buffer")
    map({ "<leader>bp", "<S-Tab>" }, ":bprevious<CR>", "Buffers", "Previous Buffer")

    -- Other
    map("<leader>z", function() Snacks.zen() end, "Snacks", "Toggle Zen Mode")
    map("<leader>Z", function() Snacks.zen.zoom() end, "Snacks", "Toggle Zoom")
    map("<leader>.", function() Snacks.scratch() end, "Snacks", "Toggle Scratch Buffer")
    map("<leader>S", function() Snacks.scratch.select() end, "Snacks", "Select Scratch Buffer")
    map("<leader>cR", function() Snacks.rename.rename_file() end, "Snacks", "Rename File")
    map("<leader>gB", function() Snacks.gitbrowse() end, "Snacks", "Git Browse", { mode = { "n", "v" } })
    map("<leader>gg", function() Snacks.lazygit() end, "Snacks", "Lazygit")
    map("<leader>un", function() Snacks.notifier.hide() end, "Snacks", "Dismiss All Notifications")
    map("<c-/>", function() Snacks.terminal() end, "Snacks", "Toggle Terminal")
    map("<c-_>", function() Snacks.terminal() end, "Snacks", "which_key_ignore")
    map("]]", function() Snacks.words.jump(vim.v.count1) end, "Snacks", "Next Reference",
      { mode = { "n", "t" } })
    map("[[", function() Snacks.words.jump(-vim.v.count1) end, "Snacks", "Prev Reference",
      { mode = { "n", "t" } })

    map("<leader>N", function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 3,
        },
      })
    end, "Snacks", "Neovim News")

    -- Close Snacks windows on quit if they are the last ones
    vim.api.nvim_create_autocmd('QuitPre', {
      callback = function()
        local snacks_windows = {}
        local floating_windows = {}
        local windows = vim.api.nvim_list_wins()
        for _, w in ipairs(windows) do
          local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(w) })
          if filetype:match('snacks_') ~= nil then
            table.insert(snacks_windows, w)
          elseif vim.api.nvim_win_get_config(w).relative ~= '' then
            table.insert(floating_windows, w)
          end
        end
        if 1 == #windows - #floating_windows - #snacks_windows then
          -- Should quit, so we close all Snacks windows.
          for _, w in ipairs(snacks_windows) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
