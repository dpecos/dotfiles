M = {}

-- conform
M.formatters = {
  lua = { "stylua" },
  javascript = { { "prettierd", "prettier" } },
  typescript = { { "prettierd", "prettier" } },
  javascriptreact = { { "prettierd", "prettier" } },
  typescriptreact = { { "prettierd", "prettier" } },
  graphql = { { "prettierd", "prettier" } },
  go = { "gofumpt", "goimports" },
  sh = { "shfmt" },
  rust = { "rustfmt" },
  json = { { "prettierd", "prettier" } },
  yaml = { "yamlfmt" },
  markdown = { "markdownlint" },
  toml = { "taplo" },
  html = { { "prettierd", "prettier" } },
  css = { "stylelint", "prettier" },
}

-- nvim-lint
M.linters = {
  javascript = { "eslint" },
  typescript = { "eslint" },
  javascriptreact = { "eslint" },
  typescriptreact = { "eslint" },
  lua = { "luacheck" },
  sh = { "shellcheck" },
  --rust = { "cargo" },
  json = { "jsonlint" },
  yaml = { "yamllint" },
  markdown = { "markdownlint" },
  css = { "stylelint" },
}

-- lspconfig
M.servers = {
  tsserver = {},
  eslint = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      },
    },
  },
  gopls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          -- library = vim.api.nvim_get_runtime_file("", true),
          library = {
            vim.fn.stdpath("config"),
          },
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  jsonls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
  bashls = {},
  prosemd_lsp = {},
  terraformls = {},
}

return M
