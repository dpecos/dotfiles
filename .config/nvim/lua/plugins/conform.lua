local formatters = require("plugins/local/mason-tools").formatters

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Conform: [f]ormat buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    formatters_by_ft = formatters,
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  --init = function()
  --   -- If you want the formatexpr, here is the place to set it
  --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
  config = function(_, opts)
    local util = require("conform.util")
    util.add_formatter_args(require("conform.formatters.yamlfmt"), { "-formatter", "retain_line_breaks=true" })
    require("conform").setup(opts)
  end,
}
