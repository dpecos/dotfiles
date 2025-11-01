-- Centralized keymap utility
-- Provides a consistent interface for creating keymaps across all plugins and configs

local M = {}

--- Create a keymap with consistent formatting
--- @param keymap string The key combination to map
--- @param handler string|function The command or function to execute
--- @param plugin string The plugin/scope name (e.g., "LSP", "Telescope", "Neovim")
--- @param description string Description of what the keymap does
--- @param opts table|nil Optional configuration (mode, buffer, nowait, expr, etc.)
function M.map(keymap, handler, plugin, description, opts)
  opts = opts or {}
  
  -- Default to normal mode if no mode specified
  local mode = opts.mode or "n"
  
  -- Build the final options table
  local final_opts = {}
  for k, v in pairs(opts) do
    if k ~= "mode" then
      final_opts[k] = v
    end
  end
  
  -- Set the description with plugin prefix
  final_opts.desc = plugin .. ": " .. description
  
  -- Create the keymap
  vim.keymap.set(mode, keymap, handler, final_opts)
end

return M
