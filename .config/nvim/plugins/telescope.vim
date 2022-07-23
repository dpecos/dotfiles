Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gl <cmd>Telescope git_commits<cr>
nnoremap <leader>gh <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>

