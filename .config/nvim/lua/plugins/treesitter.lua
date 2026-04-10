vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- Languages to ensure are installed
local ensure_installed = {
  -- Systems programming
  "c",
  "cpp",
  "rust",
  "go",

  -- Scripting
  "lua",
  "python",
  "bash",
  "javascript",
  "typescript",
  "query",
  "regex",

  -- Web development
  "html",
  "css",
  "vue",
  "svelte",
  "markdown",
  "markdown_inline",
  "json",
  "yaml",
  "toml",

  -- Data
  "sql",
  "xml",
  "csv",

  -- Build systems
  "dockerfile",
  "make",
  "cmake",

  -- Others
  "vim",
  "query",
  "regex",
  "comment",
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'markdown',
  'markdown_inline',
}

-- Enable treesitter for all filetypes that have a parser available
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
  end,
})

-- Setup function - call this to initialize treesitter
local function setup()
  local ts_ok, ts = pcall(require, "nvim-treesitter")
  if not ts_ok then
    vim.notify("Failed to load nvim-treesitter: " .. ts, vim.log.levels.ERROR, { title = "Treesitter" })
  else
    ts.install(ensure_installed)
    ts.update()
  end
end

setup()
