set nocompatible              " be iMproved, required
filetype off                  " required

" ===== plugins =====
if !exists('g:vscode')
  call plug#begin('~/.vim/plugged')

  Plug 'editorconfig/editorconfig-vim'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'

  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'ryanoasis/vim-devicons'

  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
  endif

  call plug#end()
endif

" ===== vim settings =====
let mapleader=","

map <C-V><Enter> :source $MYVIMRC<CR>
map <C-V><leader> :tabedit $MYVIMRC<CR>

set clipboard+=unnamedplus

" ===== syntax =====
set autoindent
set smartindent
syntax on
set number

" ===== theme =====
autocmd vimenter * ++nested colorscheme gruvbox

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

" ===== change cursor depending on the mode =====
" underline current editing line
":autocmd InsertEnter * set cul
":autocmd InsertLeave * set nocul

"Cursor settings:
"SI = INSERT mode
"SR = REPLACE mode
"EI = NORMAL mode (ELSE)
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" ===== other ====
" improve integration with tmux / zsh
set timeoutlen=1000 ttimeoutlen=0

" ===== navigation ====
" After shifting a visual block, reselect it to be able to shift again
vnoremap > >gv
vnoremap < <gv

" ===== fzf search =====
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Ag<CR>

" ===== NERDTree =====
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

" trigger sync when switching buffers
nnoremap <silent> <C-k> :bnext<CR>:call SyncTree()<CR>
nnoremap <silent> <C-j> :bprev<CR>:call SyncTree()<CR>

" trigger sync when opening nerdtree
nnoremap <silent> <C-n> :NERDTreeToggle<cr><c-w>l:call SyncTree()<cr><c-w>h

" ===== gVim =====
if has("gui_running")
  set lines=50 columns=150
endif

" ===== local settings =====
" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
