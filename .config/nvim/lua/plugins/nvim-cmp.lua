local setup = function()
  -- autocomplete
  local cmp = require("cmp")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local select_next = function(fallback)
    if not cmp.select_next_item() then
      if vim.bo.buftype ~= "prompt" and has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end
  end

  local select_previous = function(fallback)
    if not cmp.select_prev_item() then
      if vim.bo.buftype ~= "prompt" and has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end
  end

  -- lspkind.lua
  local lspkind = require("lspkind")
  lspkind.init({
    symbol_map = {
      Copilot = "",
    },
  })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-u>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-l>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items
      ["<C-p>"] = cmp.mapping(select_next, { "i", "s" }),
      ["<C-o>"] = cmp.mapping(select_previous, { "i", "s" }),
      ["<Tab>"] = cmp.mapping(select_next, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(select_previous, { "i", "s" }),
      ["<C-y>"] = nil, -- this clashes with copilot
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
      { name = "spell" },
      { name = "vsnip" },
      { name = "copilot" },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        -- max_width = 50,
        ellipsis_char = "...",
        symbol_map = { Copilot = "" },
      }),
    },
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
      { name = "buffer" },
    }),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
  })
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "zbirenbaum/copilot-cmp",
    "onsails/lspkind.nvim",
  },
  event = "VeryLazy",
  config = function()
    setup()
  end,
}
