let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/editorconfig-vim.vim

if !exists('g:vscode')
  source ~/.config/nvim/plugins/vim-airline.vim
  source ~/.config/nvim/plugins/gruvbox.vim

  source ~/.config/nvim/plugins/nvim-tree.vim
  source ~/.config/nvim/plugins/telescope.vim
endif

source ~/.config/nvim/plugins/nvim-treesitter.vim
source ~/.config/nvim/plugins/nvim-lsp.vim
source ~/.config/nvim/plugins/nvim-cmp.vim

call plug#end()
doautocmd User PlugLoaded
