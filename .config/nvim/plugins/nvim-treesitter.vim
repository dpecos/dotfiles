Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

function TreeSitterSetup()
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true
  },
}
EOF
endfunction

augroup TreeSitterSetup
  autocmd!
  autocmd User PlugLoaded call TreeSitterSetup()
augroup END

