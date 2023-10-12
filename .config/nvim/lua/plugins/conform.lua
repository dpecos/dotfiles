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
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      go = { "gofmt", "goimports" },
      sh = { "shfmt" },
      rust = { "rustfmt" },
      terraform = { "terraform_fmt" },
      json = { { "prettierd", "prettier" } },
      yaml = { "yamlfmt" },
      markdown = { "markdownlint" },
      toml = { "taplo" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  -- init = function()
  --   -- If you want the formatexpr, here is the place to set it
  --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
  -- -- This function is optional, but if you want to customize formatters do it here
  -- config = function(_, opts)
  --   local util = require("conform.util")
  --   util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "2" })
  --   require("conform").setup(opts)
  -- end,
}
