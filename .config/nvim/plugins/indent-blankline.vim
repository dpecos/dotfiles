Plug 'lukas-reineke/indent-blankline.nvim'

function IndentBlankLineSetup()
lua << EOF
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
EOF
endfunction

augroup IndentBlankLineSetup
  autocmd!
  autocmd User PlugLoaded call IndentBlankLineSetup()
augroup END
