-- [[ Setting options ]]
-- See `:help vim.opt`

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
-- vim.opt.mouse = 'a'

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Update time
vim.opt.updatetime = 50
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.opt.termguicolors = true
--vim.cmd [[colorscheme onedark]]
vim.opt.colorcolumn = "80"

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Text indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Save undo history
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- TODO
--set clipboard+=unnamedplus
--set splitright
