return {
  dir = '~/.nvim/config/lua/plugins/local/toggle-char',
  name = 'toggle_char',
  event = 'VeryLazy',
  config = function()
    require('plugins/local/toggle-char').setup({
      keys = { ',', ';' }
    })
  end
}
