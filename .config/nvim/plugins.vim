let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/editorconfig-vim.vim

if !exists('g:vscode')
  source ~/.config/nvim/plugins/lualine-nvim.vim
  source ~/.config/nvim/plugins/vscode-nvim.vim

  source ~/.config/nvim/plugins/nvim-tree.vim
  source ~/.config/nvim/plugins/telescope.vim
  source ~/.config/nvim/plugins/vim-fugitive.vim
  source ~/.config/nvim/plugins/indent-blankline.vim
  source ~/.config/nvim/plugins/barbar.vim
  source ~/.config/nvim/plugins/diffview.vim

  source ~/.config/nvim/plugins/mason.vim

  source ~/.config/nvim/plugins/nvim-treesitter.vim
  source ~/.config/nvim/plugins/nvim-treesitter-textobjects.vim
  source ~/.config/nvim/plugins/nvim-lsp.vim
  source ~/.config/nvim/plugins/nvim-cmp.vim

  source ~/.config/nvim/plugins/vimux.vim
endif

"source ~/.config/nvim/plugins/neoformat.vim
source ~/.config/nvim/plugins/formatter.vim
source ~/.config/nvim/plugins/vim-commentary.vim
source ~/.config/nvim/plugins/vim-surround.vim
source ~/.config/nvim/plugins/nvim-autopairs.vim

call plug#end()
doautocmd User PlugLoaded
