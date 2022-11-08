Plug 'mhartington/formatter.nvim'

nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END

function FormatterSetup()
lua << EOF

-- Utilities for creating configurations
local util = require "formatter.util"

local prettier = require('formatter.defaults.prettier')
local prettiereslint = require('formatter.defaults.prettiereslint')

local lua = require('formatter.filetypes.lua')
local go = require('formatter.filetypes.go')
local rust = require('formatter.filetypes.rust')

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    lua = { lua.luaformat },

    javascript = { prettiereslint, prettier },
    typescript =  { prettiereslint, prettier },
    javascriptreact = { prettier },
    typescriptreact = { prettier },
    vue = { prettier },
    ['javascript.jsx'] = { prettier },
    ['typescript.tsx'] = { prettier },
    markdown = { prettier },
    css = { prettier },
    json = { prettier },
    jsonc = { prettier },
    scss = { prettier },
    less = { prettier },
    yaml = { prettier },
    graphql = { prettier },
    html = { prettier },

    go = { go.gofmt },
    rust = { rust.rustfmt },

    -- Use the special "*" filetype for defining formatter configurations on any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any filetype
      -- require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

EOF
endfunction

augroup FormatterSetup
  autocmd!
  autocmd User PlugLoaded call FormatterSetup()
augroup END
