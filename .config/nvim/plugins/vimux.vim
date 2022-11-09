Plug 'preservim/vimux'
Plug 'tyewang/vimux-jest-test'
Plug 'jtdowney/vimux-cargo'

" t (lang) (action) (mod)

" typescript / javascript
nnoremap <leader>ttta <cmd>RunJest<cr>
nnoremap <leader>ttt <cmd>RunJestOnBuffer<cr>
nnoremap <leader>tttt <cmd>RunJestFocused<cr>

" rust
nnoremap <leader>trr <cmd>CargoRun<CR>
nnoremap <leader>trta <cmd>CargoTestAll<CR>
nnoremap <leader>trt <cmd>CargoUnitTestCurrentFile<CR>
nnoremap <leader>trtt <cmd>CargoUnitTestFocused<CR>

" vimux commands
nnoremap <leader>tc <cmd>VimuxCloseRunner<cr>
nnoremap <leader>tcl <cmd>VimuxClearTerminalScreen<cr>
nnoremap <leader>ti <cmd>VimuxInspectRunner<cr>
nnoremap <leader>tz <cmd>VimuxZoomRunner<cr> " <bind-key> z to restore
