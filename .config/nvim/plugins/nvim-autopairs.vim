Plug 'windwp/nvim-autopairs'

function AutopairsSetup()
lua << EOF
require('nvim-autopairs').setup({
  fast_wrap = {},
})
EOF
endfunction

augroup AutopairsSetup
  autocmd!
  autocmd User PlugLoaded call AutopairsSetup()
augroup END

