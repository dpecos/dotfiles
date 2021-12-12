Plug 'sbdchd/neoformat'

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Have Neoformat look for a formatter executable in the node_modules/.bin
let g:neoformat_try_node_exe = 1
