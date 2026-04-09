-- based on https://github.com/saifulapm/chartoggle.nvim

local function toggle(character)
  local buf = vim.api.nvim_get_current_buf()
  local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")

  if not modifiable then
    return
  end

  local api = vim.api
  local delimiters = { ",", ";" }
  local line = api.nvim_get_current_line()
  local last_char = line:sub(-1)

  if last_char == character then
    return api.nvim_set_current_line(line:sub(1, #line - 1))
  elseif vim.tbl_contains(delimiters, last_char) then
    return api.nvim_set_current_line(line:sub(1, #line - 1) .. character)
  else
    return api.nvim_set_current_line(line .. character)
  end
end

local function map(mode, target, source, opts)
  vim.keymap.set(mode, target, source, opts)
end

local M = {}

M.setup = function(options)
  for _, key in ipairs(options.keys) do
    map(
      "n",
      key .. key,
      function() toggle(key) end,
      { noremap = true, silent = true, desc = 'Toggle end char "' .. key .. '"' }
    )
  end
end

return M
