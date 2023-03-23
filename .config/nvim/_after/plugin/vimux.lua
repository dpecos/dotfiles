--  t (lang) (action) (mod)

-- typescript / javascript
vim.api.nvim_set_keymap('n', '<leader>ttta', '<cmd>RunJest<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>ttt', '<cmd>RunJestOnBuffer<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>tttt', '<cmd>RunJestFocused<cr>', {})

-- rust
vim.api.nvim_set_keymap('n', '<leader>trr', '<cmd>CargoRun<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>trta', '<cmd>CargoTestAll<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>trt', '<cmd>CargoUnitTestCurrentFile<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>trtt', '<cmd>CargoUnitTestFocused<CR>', {})

-- vimux commands
vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>VimuxCloseRunner<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>tcl', '<cmd>VimuxClearTerminalScreen<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>ti', '<cmd>VimuxInspectRunner<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>tz', '<cmd>VimuxZoomRunner<cr>', {}) -- <bind-key> z to restore
