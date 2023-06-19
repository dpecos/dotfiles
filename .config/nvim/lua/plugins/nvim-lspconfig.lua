local servers = {
  tsserver = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      }
    }
  },
  gopls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          -- library = vim.api.nvim_get_runtime_file("", true),
          library = {
            vim.fn.stdpath("config"),
          },
          checkThirdParty = false
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false
        }
      }
    }
  },
  jsonls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false
      }
    }
  },
  bashls = {},
  prosemd_lsp = {},
  terraformls = {}
}

local on_attach = function(client, bufnr)
  -- DPM: copied from https://github.com/ThePrimeagen/init.lua/blob/master/after/plugin/lsp.lua#L55
  -- but disabled because it's blocking other LSPs from attaching to the buffer
  -- if client.name == "eslint" then
  --   vim.cmd.LspStop('eslint')
  --   return
  -- end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  local function map(scope, mode, keys, func, opts)
    opts.buffer = bufnr
    opts.desc = (scope or 'Unknown scope') .. ': ' .. opts.desc

    vim.keymap.set(mode, keys, func, opts)
  end

  local nmap_lsp = function(keys, func, desc, opts)
    opts = opts or {}
    opts.desc = desc

    map('LSP', 'n', keys, func, opts)
  end

  nmap_lsp('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap_lsp('gDv', ':vsplit | lua vim.lsp.buf.declaration()<CR>', '[G]oto [D]eclaration (vertical split)')
  nmap_lsp('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap_lsp('gdv', ':vsplit | lua vim.lsp.buf.definition()<CR>', '[G]oto [D]efinition (vertical split)')
  nmap_lsp('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap_lsp('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap_lsp('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap_lsp('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap_lsp('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap_lsp('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap_lsp('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap_lsp('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostic')

  nmap_lsp('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap_lsp('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  if client.server_capabilities.documentFormattingProvider then
    nmap_lsp('<leader>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat current buffer (DFP)')
    -- vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
  else
    nmap_lsp('<leader>f', ':Format<cr>', '[F]ormat current buffer (Formatter)')
    -- vim.cmd [[ autocmd BufWritePre <buffer> FormatWrite ]]
  end

  nmap_lsp('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
  nmap_lsp(']d', vim.diagnostic.goto_next, 'Next diagnostic')
  nmap_lsp('[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, 'Previous error')
  nmap_lsp(']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, 'Next error')

  local map_gs = function(mode, keys, func, desc, opts)
    opts = opts or {}
    opts.desc = desc

    map('GitSigns', 'n', keys, func, opts)
  end

  local nmap_gs = function(keys, func, desc, opts)
    map_gs('n', keys, func, desc, opts)
  end

  local gs = package.loaded.gitsigns

  -- Navigation
  nmap_gs(']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, 'Next [c]hange', { expr = true })

  nmap_gs('[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, 'Previous [c]hange', { expr = true })

  -- Actions
  map_gs({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', '[h]unk [s]tage')
  map_gs({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', '[h]unk [r]eset')
  nmap_gs('<leader>hS', gs.stage_buffer, 'stage buffer')
  nmap_gs('<leader>hu', gs.undo_stage_hunk, '[h]unk [u]nstage')
  nmap_gs('<leader>hR', gs.reset_buffer, 'reset buffer')
  nmap_gs('<leader>hp', gs.preview_hunk, '[h]unk [p]review')
  nmap_gs('<leader>hb', function() gs.blame_line { full = true } end, '[h]unk [b]lame')
  nmap_gs('<leader>tb', gs.toggle_current_line_blame, '[t]oggle [b]lame for current line')
  nmap_gs('<leader>hd', gs.diffthis, '[h]unk [d]iff')
  nmap_gs('<leader>hD', function() gs.diffthis('~') end, '[h]unk [d]iff ~')
  nmap_gs('<leader>td', gs.toggle_deleted, '[t]oggle [d]eleted')

  -- Text object
  map_gs({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'select hunk')

  -- Symbols
  nmap_lsp('<leader>s', require('symbols-outline').toggle_outline, 'Tooggle [S]ymbols outline')
end

local _border = "single"

local setup = function()
  -- bordered floating windows
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })

  -- enable diagnostic test at the EOL where the problem is
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●',
      -- spacing = 0,
    },
    float = { border = _border }
  })

  -- enable signs column
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- folds
  lsp_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  -- LSP setup
  require('mason').setup()
  local masonLsp = require('mason-lspconfig')
  local lspconfig = require('lspconfig')

  local ensure_installed = vim.tbl_keys(servers)
  masonLsp.setup({
    ensure_installed = ensure_installed
  })

  masonLsp.setup_handlers({
    function(server_name)
      local config = servers[server_name]
      if type(config) ~= "table" then
        config = {}
      end

      config = vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = lsp_capabilities,
      }, config)

      lspconfig[server_name].setup(config)
    end,
  })

  require('fidget').setup({
    window = {
      blend = 0 -- transparent
    }
  })

  -- null-ls
  local null_ls = require("null-ls")
  local b = null_ls.builtins
  null_ls.setup({
    sources = {
      -- b.formatting.stylua,
      b.formatting.prettier,
      -- b.formatting.prettier_eslint,
      -- b.formatting.eslint_d,
      -- b.formatting.eslint,
      -- b.formatting.black,
      -- b.formatting.shfmt,
      -- b.formatting.goimports,
      -- b.formatting.gofumpt,
      -- b.formatting.gofmt,
      -- b.formatting.rustfmt,
      -- b.formatting.lua_format,
      -- b.formatting.lua_fmt,
      -- b.formatting.sqlform
    }
  })
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    'hrsh7th/nvim-cmp',

    "jose-elias-alvarez/null-ls.nvim",

    'lewis6991/gitsigns.nvim',

    { 'j-hui/fidget.nvim', tag = 'legacy' }
  },
  config = function()
    setup()
  end
}
