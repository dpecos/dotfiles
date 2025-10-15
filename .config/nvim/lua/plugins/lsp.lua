-- LSP Configuration
-- Native Neovim 0.11+ LSP setup (no nvim-lspconfig needed)
--
-- Uses native vim.lsp.config/enable for LSP configuration with native completion, formatting, and diagnostics
-- Includes fidget.nvim for LSP progress notifications and gitsigns.nvim for git integration
-- Format-on-save with Biome for JS/TS and automatic import organization

-- Using native vim.lsp.supports_method (0.11+) instead of custom wrapper
local function client_supports_method(client, method, bufnr)
  return client:supports_method(method, { bufnr = bufnr })
end

local on_lsp_attach = function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- Enable completion triggered by <c-x><c-o>
  -- Using vim.bo instead of deprecated vim.api.nvim_buf_set_option
  vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo[event.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"

  -- Enable native LSP completion (Neovim 0.11+)
  -- Using native completion exclusively (nvim-cmp removed)
  if vim.fn.has("nvim-0.11") == 1 then
    vim.lsp.completion.enable(true, client.id, event.buf, {
      autotrigger = true,
      -- Convert LSP completion items to Vim completion items
      convert = function(item)
        -- Customize completion item conversion if needed
        return item
      end,
    })
  end

  -- Setup snippet expansion using native vim.snippet (Neovim 0.10+)
  -- This replaces the need for snippet plugins like vsnip or luasnip

  local function map(scope, mode, keys, func, opts)
    opts.buffer = event.buf
    opts.desc = (scope or "Unknown scope") .. ": " .. opts.desc

    vim.keymap.set(mode, keys, func, opts)
  end

  local map_lsp = function(keys, func, desc, opts)
    opts = opts or {}
    opts.desc = desc

    map("LSP", "n", keys, func, opts)
  end

  map_lsp("gD", vim.lsp.buf.declaration, "Goto Declaration")
  map_lsp("gDv", ":vsplit | lua vim.lsp.buf.declaration()<CR>", "Goto Declaration (vertical split)")
  map_lsp("gd", vim.lsp.buf.definition, "Goto Definition")
  map_lsp("gdv", ":vsplit | lua vim.lsp.buf.definition()<CR>", "Goto Definition (vertical split)")
  map_lsp("grr", require("telescope.builtin").lsp_references, "List References")
  map_lsp("gri", require("telescope.builtin").lsp_implementations, "List Implementation")
  -- nmap_lsp("gld", require("telescope.builtin").lsp_definitions, "List Definitions")
  -- nmap_lsp("gltd", require("telescope.builtin").lsp_type_definitions, "List Type Definitions")
  map_lsp("gO", require("telescope.builtin").lsp_document_symbols, "List Document Symbols")
  map_lsp("grn", vim.lsp.buf.rename, "Rename")
  map_lsp("gra", vim.lsp.buf.code_action, "Code Action")

  map_lsp("K", function()
    vim.lsp.buf.hover({ border = "rounded" })
  end, "Documentation")
  map_lsp("<leader>k", function()
    vim.lsp.buf.signature_help({ border = "rounded" })
  end, "Signature Documentation")

  -- Native snippet navigation (Neovim 0.10+)
  -- Jump forward/backward in snippets - replaces vsnip keymaps
  vim.keymap.set({ "i", "s" }, "<C-f>", function()
    if vim.snippet.active({ direction = 1 }) then
      return vim.snippet.jump(1)
    end
  end, { buffer = event.buf, expr = true, desc = "Snippet: Jump forward" })

  vim.keymap.set({ "i", "s" }, "<C-b>", function()
    if vim.snippet.active({ direction = -1 }) then
      return vim.snippet.jump(-1)
    end
  end, { buffer = event.buf, expr = true, desc = "Snippet: Jump backward" })

  -- Native LSP Formatting (replaces conform.nvim)
  -- Format on save using LSP's native formatting capability
  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_formatting, event.buf) then
    local formatFn = function()
      -- Skip if formatting is disabled
      if vim.g.disable_autoformat or vim.b[event.buf].disable_autoformat then
        return
      end

      -- Skip node_modules
      local bufname = vim.api.nvim_buf_get_name(event.buf)
      if bufname:match("/node_modules/") then
        return
      end

      -- If Biome is attached, use it
      local biome_client = vim.lsp.get_clients({ bufnr = event.buf, name = "biome" })[1]
      if biome_client then
        -- Format with Biome
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 2000,
          bufnr = event.buf,
          filter = function(client_filter)
            return client_filter.name == "biome"
          end,
        })
      else
        -- Otherwise, use the first available LSP client that supports formatting
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 1000,
          bufnr = event.buf,
        })
      end
    end

    -- Manual format keymap
    map_lsp("<leader>f", function()
      formatFn()
    end, "Format buffer")

    -- Format on save (can be disabled per buffer or globally)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      callback = formatFn,
    })
  end

  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf }) -- enable inlay hints by default with buffer parameter

    map_lsp("<leader>h", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
    end, "Toggle inlay Hints")
  end

  -- Toggle diagnostic virtual text (inline linting messages)
  map_lsp("<leader>d", function()
    local current_config = vim.diagnostic.config()

    -- Cycle through 3 modes:
    -- 1. virtual_text only (default - inline)
    -- 2. virtual_lines only (below code)
    -- 3. Both off (minimal)

    local virtual_text_enabled = current_config.virtual_text ~= false
    local virtual_lines_enabled = current_config.virtual_lines ~= false

    if virtual_text_enabled and not virtual_lines_enabled then
      -- Mode 1 -> Mode 2: Enable virtual_lines, disable virtual_text
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = true,
      })
      vim.notify("Diagnostics: Virtual lines (below code)", vim.log.levels.INFO)
    elseif virtual_lines_enabled and not virtual_text_enabled then
      -- Mode 2 -> Mode 3: Disable both
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
      })
      vim.notify("Diagnostics: Minimal (signs & underline only)", vim.log.levels.INFO)
    else
      -- Mode 3 -> Mode 1: Enable virtual_text, disable virtual_lines
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
          source = "if_many",
        },
        virtual_lines = false,
      })
      vim.notify("Diagnostics: Virtual text (inline)", vim.log.levels.INFO)
    end
  end, "Toggle diagnostic display mode")

  map_lsp("[e", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, "Previous error")
  map_lsp("]e", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, "Next error")
  map_lsp("[w", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  end, "Previous warn")
  map_lsp("]w", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  end, "Next warn")

  -- GitSigns mappings --
  local map_gs = function(mode, keys, func, desc, opts)
    opts = opts or {}
    opts.desc = desc

    map("GitSigns", "n", keys, func, opts)
  end

  local nmap_gs = function(keys, func, desc, opts)
    map_gs("n", keys, func, desc, opts)
  end

  local gs = package.loaded.gitsigns

  -- Navigation
  nmap_gs("]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, "Next change", { expr = true })

  nmap_gs("[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, "Previous change", { expr = true })

  -- Actions
  map_gs({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "hunk stage")
  map_gs({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "hunk reset")
  nmap_gs("<leader>hS", gs.stage_buffer, "stage buffer")
  nmap_gs("<leader>hu", gs.undo_stage_hunk, "hunk unstage")
  nmap_gs("<leader>hR", gs.reset_buffer, "reset buffer")
  nmap_gs("<leader>hp", gs.preview_hunk, "hunk preview")
  nmap_gs("<leader>hb", function()
    gs.blame_line({ full = true })
  end, "hunk blame")
  nmap_gs("<leader>tb", gs.toggle_current_line_blame, "toggle blame for current line")
  nmap_gs("<leader>hd", gs.diffthis, "hunk diff")
  nmap_gs("<leader>hD", function()
    gs.diffthis("~")
  end, "hunk diff ~")
  nmap_gs("<leader>td", gs.toggle_deleted, "toggle deleted")
  -- Text object
  map_gs({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")

  -- End of GitSigns mappings --

  -- The following autocommands are used to highlight references of the word under your cursor when your cursor rests there for a little while.
  if
      client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
  then
    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
      end,
    })
  end
end

local setup = function()
  -- Native diagnostic configuration (Neovim 0.10+)
  vim.diagnostic.config({
    virtual_lines = false, -- Disabled by default (toggle with <leader>d)
    virtual_text = {
      prefix = "●",
      spacing = 4,
      source = "if_many",
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "single",
      source = true,
    },
    -- Native sign configuration (Neovim 0.10+)
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        [vim.diagnostic.severity.WARN] = "WarningMsg",
      },
    },
  })

  -- LSP setup using native vim.lsp.config/enable (Neovim 0.11+)
  -- This replaces nvim-lspconfig completely
  local mason_tools = require("plugins/local/mason-tools")

  for server, config in pairs(mason_tools.servers) do
    local lsp_server_name = config.lsp_server_name or server
    local server_config = vim.tbl_deep_extend("force", {}, config)
    server_config.lsp_server_name = nil

    -- Configure and enable the server using native API
    vim.lsp.config(lsp_server_name, server_config)
    vim.lsp.enable(lsp_server_name)
  end

  -- Native LspAttach autocmd (Neovim 0.8+)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = on_lsp_attach,
  })

  -- Commands to enable/disable auto-formatting (replaces conform commands)
  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
    print("Auto-formatting disabled" .. (args.bang and " (buffer)" or " (global)"))
  end, {
    desc = "Disable LSP format-on-save",
    bang = true,
  })

  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    print("Auto-formatting enabled")
  end, {
    desc = "Re-enable LSP format-on-save",
  })

  vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format({ async = false })
  end, {
    desc = "Format current buffer using LSP",
  })

  -- LspInfo command - Display information about attached LSP clients
  vim.api.nvim_create_user_command("LspInfo", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
      vim.notify("No LSP clients attached to this buffer", vim.log.levels.INFO)
      return
    end

    -- Create a new buffer for the info display
    local info_buf = vim.api.nvim_create_buf(false, true)
    local lines = {}

    table.insert(lines, "LSP Client Information")
    table.insert(lines, "======================")
    table.insert(lines, "")
    table.insert(lines, "Buffer: " .. vim.api.nvim_buf_get_name(bufnr))
    table.insert(lines, "Filetype: " .. vim.bo[bufnr].filetype)
    table.insert(lines, "")
    table.insert(lines, "Attached Clients (" .. #clients .. "):")
    table.insert(lines, "")

    for i, client in ipairs(clients) do
      table.insert(lines, string.format("Client #%d:", i))
      table.insert(lines, string.format("  Name: %s", client.name))
      table.insert(lines, string.format("  ID: %d", client.id))
      table.insert(lines, string.format("  Root Dir: %s", client.root_dir or "N/A"))

      -- Show key capabilities
      local caps = client.server_capabilities
      table.insert(lines, "  Capabilities:")
      if caps.completionProvider then
        table.insert(lines, "    ✓ Completion")
      end
      if caps.hoverProvider then
        table.insert(lines, "    ✓ Hover")
      end
      if caps.signatureHelpProvider then
        table.insert(lines, "    ✓ Signature Help")
      end
      if caps.definitionProvider then
        table.insert(lines, "    ✓ Go to Definition")
      end
      if caps.declarationProvider then
        table.insert(lines, "    ✓ Go to Declaration")
      end
      if caps.referencesProvider then
        table.insert(lines, "    ✓ Find References")
      end
      if caps.documentFormattingProvider then
        table.insert(lines, "    ✓ Formatting")
      end
      if caps.documentRangeFormattingProvider then
        table.insert(lines, "    ✓ Range Formatting")
      end
      if caps.renameProvider then
        table.insert(lines, "    ✓ Rename")
      end
      if caps.codeActionProvider then
        table.insert(lines, "    ✓ Code Actions")
      end
      if caps.documentHighlightProvider then
        table.insert(lines, "    ✓ Document Highlight")
      end
      if caps.inlayHintProvider then
        table.insert(lines, "    ✓ Inlay Hints")
      end

      table.insert(lines, "")
    end

    -- Show all available LSP servers (configured but maybe not attached)
    table.insert(lines, "Configured LSP Servers:")
    table.insert(lines, "")
    local mason_tools = require("plugins/local/mason-tools")
    for server, config in pairs(mason_tools.servers) do
      local lsp_name = config.lsp_server_name or server
      local is_attached = false
      for _, client in ipairs(clients) do
        if client.name == lsp_name then
          is_attached = true
          break
        end
      end
      table.insert(lines, string.format("  %s %s", is_attached and "✓" or "○", lsp_name))
    end

    vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)
    vim.bo[info_buf].modifiable = false
    vim.bo[info_buf].buftype = "nofile"
    vim.bo[info_buf].bufhidden = "wipe"
    vim.bo[info_buf].filetype = "lspinfo"

    -- Open in a split window
    vim.cmd("split")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, info_buf)
    vim.api.nvim_win_set_height(win, math.min(#lines + 2, 30))

    -- Add keybinding to close the window
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = info_buf, silent = true, desc = "Close LspInfo" })
  end, {
    desc = "Display LSP client information",
  })

  -- LspLog command - Open LSP log file
  vim.api.nvim_create_user_command("LspLog", function()
    local log_path = vim.lsp.get_log_path()

    if vim.fn.filereadable(log_path) == 0 then
      vim.notify("LSP log file not found at: " .. log_path, vim.log.levels.WARN)
      return
    end

    -- Open log file in a new buffer
    vim.cmd("split " .. vim.fn.fnameescape(log_path))

    -- Set some useful options for the log buffer
    vim.bo.readonly = true
    vim.bo.modifiable = false
    vim.wo.wrap = false

    -- Jump to the end of the file
    vim.cmd("normal! G")

    vim.notify("LSP log opened. Press 'q' to close.", vim.log.levels.INFO)

    -- Add keybinding to close the window
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true, desc = "Close LspLog" })
  end, {
    desc = "Open LSP log file",
  })

  -- LspRestart command - Restart all LSP clients for current buffer
  vim.api.nvim_create_user_command("LspRestart", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
      vim.notify("No LSP clients attached to this buffer", vim.log.levels.INFO)
      return
    end

    for _, client in ipairs(clients) do
      vim.notify("Restarting " .. client.name .. "...", vim.log.levels.INFO)
      -- Stop the client
      vim.lsp.stop_client(client.id)
    end

    -- Re-enable servers after a short delay
    vim.defer_fn(function()
      local mason_tools = require("plugins/local/mason-tools")
      for server, config in pairs(mason_tools.servers) do
        local lsp_server_name = config.lsp_server_name or server
        vim.lsp.enable(lsp_server_name)
      end
      vim.notify("LSP clients restarted", vim.log.levels.INFO)
    end, 500)
  end, {
    desc = "Restart LSP clients for current buffer",
  })
end

return {
  -- Note: No longer need nvim-lspconfig as a plugin
  -- Using native vim.lsp.config/enable (Neovim 0.11+)
  {
    -- Useful status updates for LSP
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0, -- transparent
        },
      },
      integration = {
        ["nvim-tree"] = {
          enable = true,
        },
      },
    },
    config = function(_, opts)
      require("fidget").setup(opts)
      -- Setup LSP after fidget is ready
      setup()
    end,
  },

  "lewis6991/gitsigns.nvim",
}
