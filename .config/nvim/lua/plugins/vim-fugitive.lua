-- Vim Fugitive
-- https://github.com/tpope/vim-fugitive
--
-- Powerful Git integration for Neovim with comprehensive Git commands
-- Commands: :G (git status), :Gcommit, :Gdiff, :Gblame, :Gpush, :Gpull
-- Lazy-loaded on :G command for better startup performance

return {
  'tpope/vim-fugitive',
  cmd = 'G'
}
