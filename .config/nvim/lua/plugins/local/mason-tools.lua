M = {}

M.formatters = {
  lua = { "stylua" },
  go = { "gofumpt", "goimports" },
  sh = { "shfmt" },
  -- rust formatting now handled by rust-analyzer LSP
  yaml = { "yamlfmt" },
  markdown = { "markdownlint" },
  toml = { "taplo" },
  -- JS/TS/JSON/CSS now handled by Biome LSP
}

M.linters = {
  -- JS/TS now handled by Biome LSP (formatting + linting)
  sh = { "shellcheck" },
  yaml = { "yamllint" },
  markdown = { "markdownlint" },
  -- CSS handled by Biome or separate LSP
}

M.servers = {
  -- Biome - Modern fast formatter/linter for JS/TS/JSON/CSS
  biome = {
    cmd = { "biome", "lsp-proxy" },
    root_markers = { "biome.json", "biome.jsonc", ".git", "package.json" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
      "html",
      "css",
      "scss",
      "less",
      "graphql",
    },
  },

  -- TypeScript Language Server (ts_ls) - Native LSP configuration
  ["typescript-language-server"] = {
    lsp_server_name = "ts_ls",
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    root_markers = {
      "tsconfig.json",
      "jsconfig.json",
      "package.json",
      ".git",
    },
    init_options = {
      hostInfo = "neovim",
    },
    on_attach = function(client, bufnr)
      -- Disable formatting - Biome handles it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        preferences = {
          importModuleSpecifierPreference = "shortest",
          importModuleSpecifierEnding = "auto",
          quotePreference = "auto",
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        preferences = {
          importModuleSpecifierPreference = "shortest",
          importModuleSpecifierEnding = "auto",
          quotePreference = "auto",
        },
      },
    },
  },

  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  },

  ["lua-language-server"] = {
    lsp_server_name = "lua_ls",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    },
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "Snacks" },
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

  ["json-lsp"] = {
    lsp_server_name = "jsonls",
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = true,
    },
  },

  ["yaml-language-server"] = {
    lsp_server_name = "yamlls",
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },

  ["bash-language-server"] = {
    lsp_server_name = "bashls",
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git" },
  },

  ["terraform-ls"] = {
    lsp_server_name = "terraformls",
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
  },

}

-- Rust-analyzer settings (used by rustaceanvim, not lspconfig)
M.rust_analyzer_settings = {
  -- Enable all features by default
  cargo = {
    allFeatures = true,
    loadOutDirsFromCheck = true,
    buildScripts = {
      enable = true,
    },
  },
  -- Enable procedural macro support
  procMacro = {
    enable = true,
    ignored = {
      ["async-trait"] = { "async_trait" },
      ["napi-derive"] = { "napi" },
      ["async-recursion"] = { "async_recursion" },
    },
  },
  -- Enhanced diagnostics
  diagnostics = {
    enable = true,
    experimental = {
      enable = true,
    },
    styleLints = {
      enable = true,
    },
  },
  -- Run clippy on save (modern schema)
  check = {
    command = "clippy",
    extraArgs = { "--all-targets" },
  },
  -- Inlay hints (modern schema - most moved to editor config)
  inlayHints = {
    bindingModeHints = {
      enable = true,
    },
    chainingHints = {
      enable = true,
    },
    closingBraceHints = {
      minLines = 25,
    },
    closureReturnTypeHints = {
      enable = "with_block",
    },
    lifetimeElisionHints = {
      enable = "skip_trivial",
      useParameterNames = true,
    },
    parameterHints = {
      enable = true,
    },
    typeHints = {
      enable = true,
      hideClosureInitialization = false,
      hideNamedConstructor = false,
    },
  },
  -- Lens
  lens = {
    enable = true,
    references = {
      adt = { enable = true },
      enumVariant = { enable = true },
      method = { enable = true },
      trait = { enable = true },
    },
  },
  -- Hover actions
  hover = {
    actions = {
      enable = true,
    },
    documentation = {
      enable = true,
    },
  },
  -- Assist
  assist = {
    importGranularity = "module",
    importPrefix = "by_crate",
  },
}

return M
