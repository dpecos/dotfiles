-- Build hook: run :TSUpdate after treesitter installs or updates
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      vim.schedule(function()
        pcall(vim.cmd, "TSUpdate")
      end)
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",              version = "main" },
  { src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim", version = "main" },
})

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
