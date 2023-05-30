return {
  'Mofiqul/vscode.nvim',
  event = 'VeryLazy',
  config = function()
    require('vscode').setup({
      style = 'dark',

      transparent = true,

      -- Enable italic comment
      italic_comments = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = false,

      -- Override colors (see ./lua/vscode/colors.lua)
      -- color_overrides = {
      --   vscLineNumber = '#FF0000',
      -- },
    })

    require('vscode').load()
  end
}
