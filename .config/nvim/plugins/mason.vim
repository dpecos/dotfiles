Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

function MasonSetup()
lua << EOF

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "vimls", "rust_analyzer", "gopls", "graphql", "html", "jsonls", "tsserver", "remark_ls", "terraformls", "yamlls" },
  automatic_installation = true,
})

EOF
endfunction

augroup MasonSetup
  autocmd!
  autocmd User PlugLoaded call MasonSetup()
augroup END
