-- Rustaceanvim
-- https://github.com/mrcjkb/rustaceanvim
--
-- Modern Rust development plugin with rust-analyzer, cargo integration, test runner, and debugger
-- Replaces rust-tools.nvim with better performance and features

return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false,   -- This plugin is already lazy
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        -- Hover actions
        hover_actions = {
          auto_focus = false,
          border = "rounded",
        },
        -- Code actions
        code_actions = {
          ui_select_fallback = true,
        },
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- Rustacean-specific keymaps
          local function map(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Rustacean: " .. desc })
          end

          -- Rust-specific keymaps
          map("n", "<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, "Runnables")

          map("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, "Testables")

          map("n", "<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, "Debuggables")

          map("n", "<leader>re", function()
            vim.cmd.RustLsp("expandMacro")
          end, "Expand macro")

          map("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, "Open Cargo.toml")

          map("n", "<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, "Parent module")

          map("n", "<leader>rj", function()
            vim.cmd.RustLsp("joinLines")
          end, "Join lines")

          map("n", "<leader>rm", function()
            vim.cmd.RustLsp({ "view", "mir" })
          end, "View MIR")

          map("n", "<leader>rh", function()
            vim.cmd.RustLsp({ "view", "hir" })
          end, "View HIR")

          -- Hover with actions
          map("n", "K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, "Hover with actions")

          -- Code actions (use LSP default)
          -- Formatting handled by native LSP format-on-save
        end,
        -- This will automatically configure rust-analyzer
        -- using the settings from mason-tools/init.lua
        default_settings = {
          -- Import settings from mason-tools
          ["rust-analyzer"] = require("plugins/local/mason-tools").rust_analyzer_settings,
        },
      },
    }
  end,
}
