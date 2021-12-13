" set leader key
let g:mapleader = ","

nmap <leader>vr :source ~/.config/nvim/init.vim<cr>
nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vk :edit ~/.config/nvim/keymaps.vim<cr>
nmap <leader>vp :edit ~/.config/nvim/plugins.vim<cr>
nmap <leader>vs :edit ~/.config/nvim/settings.vim<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Better tabbing: reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Make Y behave like the other capitals
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>

" Quicky escape to normal mode
imap jk <esc>

" Easy insertion of a trailing ; or , from insert mode
map ;; <Esc>A;<Esc>
map ,, <Esc>A,<Esc>

" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<ESC>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

cmap w!! %!sudo tee > /dev/null %

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

