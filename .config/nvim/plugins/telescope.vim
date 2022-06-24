Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgl <cmd>Telescope git_commits<cr>
nnoremap <leader>fgh <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>

