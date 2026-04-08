-- VSCode Theme
-- https://github.com/Mofiqul/vscode.nvim

require("vscode").setup({
  style            = "dark",
  transparent      = true,
  italic_comments  = true,
  disable_nvimtree_bg = false,
  color_overrides  = {
    vscCursorDarkDark = "#363636",
  },
})

require("vscode").load()
