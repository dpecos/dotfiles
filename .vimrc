" ===== plugins =====
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
"Plugin 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ===== vim settings =====
map <C-V><Enter> :source $MYVIMRC<CR>
map <C-V><C-Enter> :tabedit $MYVIMRC<CR>

set clipboard=unnamed

" ===== syntax =====
set nocompatible 
set autoindent 
set smartindent
syntax on

" ===== theme =====
let g:airline_powerline_fonts = 1
"let g:airline_theme='bubblegum'

" Always show statusline
set laststatus=2

" ===== search =====
set hlsearch
set incsearch
set smartcase "does case-insensitive searches only when all letters are lowercase
" toggle highlighting matches
nnoremap <F3> :set hlsearch!<CR>
" clear last search
nnoremap <F4> :let @/ = ""<CR>

" ===== other ====
" improve integration with tmux / zsh
set timeoutlen=1000 ttimeoutlen=0

" ===== navigation ====
" After shifting a visual block, reselect it to be able to shift again
vnoremap > >gv
vnoremap < <gv

" ===== NERDTree =====
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0


" ===== local settings =====
" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
