require('vscode').setup({
  transparent = false,

  -- Enable italic comment
  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = false,

  -- Override colors (see ./lua/vscode/colors.lua)
  -- color_overrides = {
  --   vscLineNumber = '#FF0000',
  -- },
})

require('vscode').change_style('dark')

-- vim.opt.background = 'dark'
--vim.cmd([[colorscheme vscode]])
