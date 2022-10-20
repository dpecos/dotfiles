" set leader key
let g:mapleader = ","

nmap <leader>vr :source ~/.config/nvim/init.vim<cr>
nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vk :edit ~/.config/nvim/keymaps.vim<cr>
nmap <leader>vp :edit ~/.config/nvim/plugins.vim<cr>
nmap <leader>vs :edit ~/.config/nvim/settings.vim<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>C :BufferClose<CR>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction
map ;; :call ToggleEndChar(';')<CR>
map ,, :call ToggleEndChar(',')<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

nnoremap <leader>bd :BufferDelete<CR>
nnoremap <leader>bc :BufferClose<CR>
nnoremap <leader>bo :BufferCloseAllButCurrent<CR>
nnoremap <leader>bp :BufferPin<CR>
nnoremap <leader>bn :BufferNext<CR>

cmap w!! %!sudo tee > /dev/null %

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

