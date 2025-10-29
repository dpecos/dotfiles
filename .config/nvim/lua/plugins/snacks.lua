return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "SNACKS: Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "SNACKS: Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "SNACKS: Grep" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "SNACKS: Command History" },
    { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "SNACKS: Notification History" },
    { "<leader>e",       function() Snacks.explorer() end,                                       desc = "SNACKS: File Explorer" },
    -- find
    { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "SNACKS: Buffers" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "SNACKS: Find Config File" },
    { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "SNACKS: Find Files" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "SNACKS: Find Git Files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "SNACKS: Projects" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "SNACKS: Recent" },
    -- git
    { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "SNACKS: Git Branches" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "SNACKS: Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "SNACKS: Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "SNACKS: Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "SNACKS: Git Stash" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "SNACKS: Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "SNACKS: Git Log File" },
    -- Grep
    { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "SNACKS: Buffer Lines" },
    { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "SNACKS: Grep Open Buffers" },
    { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "SNACKS: Grep" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "SNACKS: Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "SNACKS: Registers" },
    { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "SNACKS: Search History" },
    { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "SNACKS: Autocmds" },
    { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "SNACKS: Buffer Lines" },
    { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "SNACKS: Command History" },
    { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "SNACKS: Commands" },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "SNACKS: Diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "SNACKS: Buffer Diagnostics" },
    { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "SNACKS: Help Pages" },
    { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "SNACKS: Highlights" },
    { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "SNACKS: Icons" },
    { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "SNACKS: Jumps" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "SNACKS: Keymaps" },
    { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "SNACKS: Location List" },
    { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "SNACKS: Marks" },
    { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "SNACKS: Man Pages" },
    { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "SNACKS: Search for Plugin Spec" },
    { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "SNACKS: Quickfix List" },
    { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "SNACKS: Resume" },
    { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "SNACKS: Undo History" },
    { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "SNACKS: Colorschemes" },
    -- LSP
    { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "SNACKS: Goto Definition" },
    { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "SNACKS: Goto Declaration" },
    { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                             desc = "SNACKS: References" },
    { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "SNACKS: Goto Implementation" },
    { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "SNACKS: Goto T[y]pe Definition" },
    { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "SNACKS: C[a]lls Incoming" },
    { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "SNACKS: C[a]lls Outgoing" },
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "SNACKS: LSP Symbols" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "SNACKS: LSP Workspace Symbols" },
    -- Other
    { "<leader>z",       function() Snacks.zen() end,                                            desc = "SNACKS: Toggle Zen Mode" },
    { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "SNACKS: Toggle Zoom" },
    { "<leader>.",       function() Snacks.scratch() end,                                        desc = "SNACKS: Toggle Scratch Buffer" },
    { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "SNACKS: Select Scratch Buffer" },
    { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "SNACKS: Notification History" },
    { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "SNACKS: Delete Buffer" },
    { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "SNACKS: Rename File" },
    { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "SNACKS: Git Browse",               mode = { "n", "v" } },
    { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "SNACKS: Lazygit" },
    { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "SNACKS: Dismiss All Notifications" },
    { "<c-/>",           function() Snacks.terminal() end,                                       desc = "SNACKS: Toggle Terminal" },
    { "<c-_>",           function() Snacks.terminal() end,                                       desc = "SNACKS: which_key_ignore" },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "SNACKS: Next Reference",           mode = { "n", "t" } },
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "SNACKS: Prev Reference",           mode = { "n", "t" } },
    {
      "<leader>N",
      desc = "SNACKS: Neovim News",
      function()
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
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "SNACKS: Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "SNACKS: Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "SNACKS: Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "SNACKS: Dark Background" }):map(
        "<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
