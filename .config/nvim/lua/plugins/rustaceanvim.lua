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
          local map = require("utils.keymap").map

          -- Rust-specific keymaps
          map("<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, "Rustacean", "Runnables", { buffer = bufnr })

          map("<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, "Rustacean", "Testables", { buffer = bufnr })

          map("<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, "Rustacean", "Debuggables", { buffer = bufnr })

          map("<leader>re", function()
            vim.cmd.RustLsp("expandMacro")
          end, "Rustacean", "Expand macro", { buffer = bufnr })

          map("<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, "Rustacean", "Open Cargo.toml", { buffer = bufnr })

          map("<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, "Rustacean", "Parent module", { buffer = bufnr })

          map("<leader>rj", function()
            vim.cmd.RustLsp("joinLines")
          end, "Rustacean", "Join lines", { buffer = bufnr })

          map("<leader>rm", function()
            vim.cmd.RustLsp({ "view", "mir" })
          end, "Rustacean", "View MIR", { buffer = bufnr })

          map("<leader>rh", function()
            vim.cmd.RustLsp({ "view", "hir" })
          end, "Rustacean", "View HIR", { buffer = bufnr })

          -- Hover with actions
          map("K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, "Rustacean", "Hover with actions", { buffer = bufnr })

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
