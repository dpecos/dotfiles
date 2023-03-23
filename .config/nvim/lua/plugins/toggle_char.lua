return {
  dir = '~/.nvim/config/lua/plugins/local/toggle_char',
  name = 'toggle_char',
  event = 'VeryLazy',
  config = function()
    require('plugins/local/toggle_char').setup({
      keys = { ',', ';' }
    })
  end
}
