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

    local function map(scope, mode, keys, func, desc, opts)
      opts = opts or {}
      opts.buffer = bufnr
      opts.desc = (scope or 'Unknown scope') .. ': ' .. desc

      vim.keymap.set(mode, keys, func, opts)
    end

    local opts = { noremap = true, silent = true, expr = false }

    -- remap to open the Telescope refactoring menu in visual mode
    map("Refactor", "v", "<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "List of possible refactors", { noremap = true })

    -- Remaps for the refactoring operations currently offered by the plugin
    map("Refactor", "v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract function", opts)
    map("Refactor", "v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], "Extract function to file", opts)
    map("Refactor", "v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract variable", opts)
    map("Refactor", "v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline variable", opts)
    -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    map("Refactor", "n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline variable", opts)

    -- Extract block doesn't need visual mode
    map("Refactor", "n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], "Extract block", opts)
    map("Refactor", "n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], "Extract block to file", opts)

  end
}
