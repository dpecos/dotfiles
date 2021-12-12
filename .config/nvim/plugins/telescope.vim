Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fg <cmd>Telescope git_status<cr>
nnoremap <leader>fl <cmd>Telescope git_commits<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>

