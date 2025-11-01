-- Refactoring
-- https://github.com/ThePrimeagen/refactoring.nvim
--
-- Treesitter-based refactoring operations for multiple languages
-- Keymaps: <leader>rr (refactor menu), <leader>re (extract function), <leader>rv (extract variable)
-- Supports: extract function/variable, inline variable, extract block to file
-- Integrates with Telescope for refactoring operation selection

return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter'
  },
  event = 'VeryLazy',
  config = function()
    require('refactoring').setup({})

    require("telescope").load_extension("refactoring")

    local map = require("utils.keymap").map

    local opts = { noremap = true, silent = true, expr = false }

    -- remap to open the Telescope refactoring menu in visual mode
    map("<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor", "List of possible refactors", { mode = "v", noremap = true })

    -- Remaps for the refactoring operations currently offered by the plugin
    map("<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Refactor", "Extract function", vim.tbl_extend("force", opts, { mode = "v" }))
    map("<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], "Refactor", "Extract function to file", vim.tbl_extend("force", opts, { mode = "v" }))
    map("<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Refactor", "Extract variable", vim.tbl_extend("force", opts, { mode = "v" }))
    map("<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Refactor", "Inline variable", vim.tbl_extend("force", opts, { mode = "v" }))
    -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    map("<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Refactor", "Inline variable", opts)

    -- Extract block doesn't need visual mode
    map("<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], "Refactor", "Extract block", opts)
    map("<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], "Refactor", "Extract block to file", opts)

  end
}
