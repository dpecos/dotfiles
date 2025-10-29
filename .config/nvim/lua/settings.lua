-- [[ Setting options ]]
-- See `:help vim.opt`

-- Enable native module loader cache (Neovim 0.9+)
-- This significantly improves startup time
vim.loader.enable()

local g = vim.g     -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Set highlight on search
opt.hlsearch = true
opt.incsearch = true

-- Make line numbers default
vim.wo.number = true
opt.relativenumber = true

-- Enable mouse mode
-- vim.opt.mouse = 'a'

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Set colorscheme
opt.termguicolors = true
--opt.colorcolumn = "80"

-- Completion popup appearance
opt.pumblend = 10  -- Slight transparency for completion menu
opt.pumheight = 15 -- Maximum number of items to show in popup menu

-- EditorConfig
g.editorconfig = true

-- Text indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Save undo history
opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.scrolloff = 8
opt.sidescrolloff = 8

-- clipboard
--vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- optimizations
opt.hidden = true -- Enable background buffers
--opt.history = 100 -- Remember N lines in history
--opt.lazyredraw = true -- Faster scrolling
--opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

--vim.opt.winbar = "%=%m %f"

-- cmd info in status line
-- opt.cmdheight = 0
-- opt.statusline = "%f - %y %=%S %l / %L"
-- opt.showcmdloc = "statusline"

-- File-type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    opt.wrap = true
  end,
})
