-- Optional: Native-only completion configuration
--
-- This file demonstrates how to use ONLY Neovim's native completion
-- without nvim-cmp. To use this approach:
--
-- 1. Remove or disable lua/plugins/nvim-cmp.lua (already removed)
-- 2. The native completion is already enabled in lua/plugins/lsp.lua
-- 3. Add custom keymaps and configuration as needed
--
-- NOTE: This provides a simpler, lighter setup but with fewer features
-- than nvim-cmp (no snippet sources, fewer completion sources, etc.)

local M = {}

-- Enhanced native completion keymaps
M.setup_keymaps = function()
  -- Insert mode completion keymaps
  local keymap_opts = { noremap = true, silent = true }

  -- Trigger LSP completion
  vim.keymap.set("i", "<C-Space>", "<C-x><C-o>",
    vim.tbl_extend("force", keymap_opts, { desc = "Native Completion: Trigger completion menu" }))

  -- Accept completion with Enter (if popup is visible)
  vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then
      return "<C-y>"
    else
      return "<CR>"
    end
  end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Native Completion: Accept selected item" }))

  -- Close completion menu with Escape
  vim.keymap.set("i", "<C-e>", function()
    if vim.fn.pumvisible() == 1 then
      return "<C-e>"
    else
      return "<Esc>"
    end
  end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Native Completion: Close menu" }))

  -- Navigate completion menu
  vim.keymap.set("i", "<C-n>", function()
    if vim.fn.pumvisible() == 1 then
      return "<C-n>"
    else
      return "<C-x><C-o>"
    end
  end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Native Completion: Next item" }))

  vim.keymap.set("i", "<C-p>", function()
    if vim.fn.pumvisible() == 1 then
      return "<C-p>"
    else
      return "<C-x><C-o>"
    end
  end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Native Completion: Previous item" }))

  -- Tab to accept or move to next completion
  vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
      return "<C-n>"
    else
      return "<Tab>"
    end
  end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Native Completion: Next item" }))

  vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
      return "<C-p>"
    else
      return "<S-Tab>"
    end
  end, vim.tbl_extend("force", keymap_opts, { expr = true, desc = "Native Completion: Previous item" }))
end

-- Call this function to set up native completion
M.setup = function()
  M.setup_keymaps()

  -- Additional native completion configuration
  vim.opt.completeopt = "menu,menuone,noselect"
  vim.opt.pumheight = 15
  vim.opt.pumblend = 10

  -- Enable preview window for completion documentation
  vim.opt.completeopt:append("preview")
end

M.setup()

return M
