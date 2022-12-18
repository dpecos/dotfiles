require('vscode').setup({
  transparent = false,

  -- Enable italic comment
  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = true,
})

vim.opt.background = 'dark'
vim.cmd([[colorscheme vscode]])
