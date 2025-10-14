-- Nvim Autopairs
-- https://github.com/windwp/nvim-autopairs
--
-- Auto-close brackets, quotes, and other pairs with Treesitter integration
-- Treesitter-aware: respects string contexts in Lua, JavaScript template strings
-- Automatically inserts closing pairs and handles deletion of pairs together

return {
  'windwp/nvim-autopairs',
  event = 'VeryLazy',
  config = function()
    require('nvim-autopairs').setup({
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
        java = false,
      },
    })
  end
}
