Plug 'preservim/vimux'
Plug 'tyewang/vimux-jest-test'

nnoremap <leader>ta <cmd>RunJest<cr>
nnoremap <leader>t <cmd>RunJestOnBuffer<cr>
nnoremap <leader>tt <cmd>RunJestFocused<cr>

nnoremap <leader>tc <cmd>VimuxCloseRunner<cr>
nnoremap <leader>tcl <cmd>VimuxClearTerminalScreen<cr>
nnoremap <leader>tf <cmd>VimuxFocusRunner<cr>
