vim.pack.add({
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range(">=6") },
})

vim.g.rustaceanvim = {
  tools = {
    hover_actions = {
      auto_focus = false,
      border     = "rounded",
    },
    code_actions = {
      ui_select_fallback = true,
    },
  },
  server = {
    on_attach = function(client, bufnr)
      local map = require("utils.keymap").map

      map("<leader>rr", function() vim.cmd.RustLsp("runnables")    end, "Rustacean", "Runnables",       { buffer = bufnr })
      map("<leader>rt", function() vim.cmd.RustLsp("testables")    end, "Rustacean", "Testables",       { buffer = bufnr })
      map("<leader>rd", function() vim.cmd.RustLsp("debuggables")  end, "Rustacean", "Debuggables",     { buffer = bufnr })
      map("<leader>re", function() vim.cmd.RustLsp("expandMacro")  end, "Rustacean", "Expand macro",    { buffer = bufnr })
      map("<leader>rc", function() vim.cmd.RustLsp("openCargo")    end, "Rustacean", "Open Cargo.toml", { buffer = bufnr })
      map("<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Rustacean", "Parent module",   { buffer = bufnr })
      map("<leader>rj", function() vim.cmd.RustLsp("joinLines")    end, "Rustacean", "Join lines",      { buffer = bufnr })
      map("<leader>rm", function() vim.cmd.RustLsp({ "view", "mir" }) end, "Rustacean", "View MIR",     { buffer = bufnr })
      map("<leader>rh", function() vim.cmd.RustLsp({ "view", "hir" }) end, "Rustacean", "View HIR",     { buffer = bufnr })

      map("K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, "Rustacean", "Hover with actions", { buffer = bufnr })
    end,
    default_settings = {
      ["rust-analyzer"] = require("plugins/local/mason-tools").rust_analyzer_settings,
    },
  },
}
