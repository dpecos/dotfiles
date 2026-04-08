-- Nvim Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
--
-- Advanced syntax highlighting, indentation, and text objects using treesitter parsers
-- Supports: Rust, JS/TS/TSX, Lua, Markdown, JSON, HTML, CSS, YAML, Bash, and more
-- Text objects: af/if (function), ac/ic (class), ab/ib (block), ai/ii (call)
-- Incremental selection: gnn (init), grn (expand), grm (shrink)
-- Includes treesitter-modules for module configuration

local languages = {
  'bash',
  'comment',
  'css',
  'diff',
  'fish',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'html',
  'javascript',
  'json',
  'latex',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'scss',
  'svelte',
  'toml',
  'tsx',
  'typescript',
  'typst',
  'vim',
  'vimdoc',
  'vue',
  'xml',
}

require("treesitter-modules").setup({
  ensure_installed = languages,
  auto_install = false,
  fold = { enable = true },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
})
