syntax enable " Enables syntax highlighing

" Appearance
set title
set number
set relativenumber
set termguicolors
set colorcolumn=80

set hidden " Required to keep multiple buffers open multiple buffers
set nowrap
set spell
set ignorecase
set smartcase
set wildmode=longest:full,full
set list
set listchars=tab:▸\ ,trail:·
set nojoinspaces
set confirm
set exrc
set redrawtime=10000 " Allow more time for loading syntax on large files:set
set clipboard+=unnamedplus
set splitright

" Amount of lines to keep in the display when scrolling (if possible)
set scrolloff=8
set sidescrolloff=8

" Undo history
set noswapfile
set nobackup
"set undodir="~/.vim/undodir"
set undofile
