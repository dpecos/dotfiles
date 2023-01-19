local ensure_installed = {
  'tsserver',
  -- 'eslint',
  'ltex',
  'sumneko_lua',
  'jsonls',
  'yamlls',
  'bashls',
  'prosemd_lsp',
  'rust_analyzer'
}

local on_attach = function(client, bufnr)
  -- DPM: copied from https://github.com/ThePrimeagen/init.lua/blob/master/after/plugin/lsp.lua#L55
  -- but disabled because it's blocking other LSPs from attaching to the buffer
  -- if client.name == "eslint" then
  --   vim.cmd.LspStop('eslint')
  --   return
  -- end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gDv', ':vsplit | lua vim.lsp.buf.declaration()<CR>', '[G]oto [D]eclaration (vertical split)')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gdv', ':vsplit | lua vim.lsp.buf.definition()<CR>', '[G]oto [D]efinition (vertical split)')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')


  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  --nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  --nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  --nmap('<leader>wl', function()
  --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, '[W]orkspace [L]ist Folders')

  if client.server_capabilities.documentFormattingProvider then
    nmap('<leader>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat current buffer (DFP)')
    vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
  else
    nmap('<leader>f', ':Format<cr>', '[F]ormat current buffer (Formatter)')
    vim.cmd [[ autocmd BufWritePre <buffer> FormatWrite ]]
  end

  nmap('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Next diagnostic')
  nmap('[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, 'Previous error')
  nmap(']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, 'Next error')
end

local lsp = require('lsp-zero')
-- lsp.preset('recommended')
-- lsp.ensure_installed(ensure_installed)
-- lsp.on_attach(on_attach)
-- lsp.setup()

-- This is required by nvim-ufo to enable folds based on LSP
-- https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = ensure_installed
})
lsp.extend_lspconfig({
  on_attach = on_attach,
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
    }
  }
})
require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({})
  end
})

lsp.set_sign_icons()
vim.diagnostic.config({
  virtual_text = true,
})
