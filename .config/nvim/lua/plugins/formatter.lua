local setup = function()
  -- Utilities for creating configurations
  local util = require "formatter.util"

  local prettierd = require('formatter.defaults.prettierd')
  local prettiereslint = require('formatter.defaults.prettiereslint')

  local lua = require('formatter.filetypes.lua')
  local go = require('formatter.filetypes.go')
  local rust = require('formatter.filetypes.rust')

  -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  require("formatter").setup {
    -- Enable or disable logging
    logging = false,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
      lua = { lua.luaformat },
      javascript = { prettierd },
      typescript = { prettierd },
      javascriptreact = { prettierd },
      typescriptreact = { prettierd },
      vue = { prettierd },
      ['javascript.jsx'] = { prettierd },
      ['typescript.tsx'] = { prettierd },
      markdown = { prettierd },
      css = { prettierd },
      json = { prettierd },
      jsonc = { prettierd },
      scss = { prettierd },
      less = { prettierd },
      yaml = { prettierd },
      graphql = { prettierd },
      html = { prettierd },
      go = { go.gofmt },
      rust = { rust.rustfmt },
      -- Use the special "*" filetype for defining formatter configurations on any filetype
      ["*"] = {
        -- "formatter.filetypes.any" defines default configurations for any filetype
        -- require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }
  }

  vim.keymap.set('n', '<leader>F', ':Format<cr>', { desc = '[Format] file using formatter plugin' })
end

return {
  "mhartington/formatter.nvim",
  event = 'VeryLazy',
  config = function()
    setup()
  end
}
