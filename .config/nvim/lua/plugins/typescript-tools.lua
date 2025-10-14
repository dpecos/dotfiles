-- Native TypeScript/JavaScript LSP configuration
-- 
-- Using native vim.lsp.config (Neovim 0.11+) with typescript-language-server (ts_ls)
-- No plugin dependencies - fully native Neovim LSP
--
-- Features:
-- ✓ Full TypeScript/JavaScript support via ts_ls
-- ✓ Import organization via LSP code actions
-- ✓ Native completion and inlay hints
-- ✓ Works with Biome for formatting/linting
--
-- This file is intentionally minimal - no plugin needed!
-- All configuration is in lua/plugins/local/mason-tools/init.lua

-- TypeScript/JavaScript import management helper
local M = {}

-- Helper to check if ts_ls is attached
local function get_ts_ls_client(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
	return clients[1]
end

-- Organize imports using native LSP
M.organize_imports = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	local client = get_ts_ls_client(bufnr)
	if not client then
		vim.notify("ts_ls client not attached", vim.log.levels.WARN)
		return
	end
	
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(bufnr) },
	}
	
	client.request("workspace/executeCommand", params, function(err, result)
		if err then
			vim.notify("Error organizing imports: " .. vim.inspect(err), vim.log.levels.ERROR)
		end
	end, bufnr)
end

-- Sort imports using native LSP
M.sort_imports = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	local client = get_ts_ls_client(bufnr)
	if not client then
		vim.notify("ts_ls client not attached", vim.log.levels.WARN)
		return
	end
	
	local params = {
		command = "_typescript.sortImports",
		arguments = { vim.api.nvim_buf_get_name(bufnr) },
	}
	
	client.request("workspace/executeCommand", params, function(err, result)
		if err then
			vim.notify("Error sorting imports: " .. vim.inspect(err), vim.log.levels.ERROR)
		end
	end, bufnr)
end

-- Remove unused imports using code actions
M.remove_unused_imports = function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.removeUnused" },
			diagnostics = {},
		},
	})
end

-- Add missing imports using code actions  
M.add_missing_imports = function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.addMissingImports" },
			diagnostics = {},
		},
	})
end

-- Fix all fixable errors
M.fix_all = function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.fixAll" },
			diagnostics = {},
		},
	})
end

-- Setup keymaps for TypeScript buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, {
				buffer = event.buf,
				desc = "TS: " .. desc,
				silent = true,
			})
		end

		-- Import management
		map("<leader>oi", M.organize_imports, "Organize imports")
		map("<leader>os", M.sort_imports, "Sort imports")
		map("<leader>ou", M.remove_unused_imports, "Remove unused imports")
		map("<leader>oa", M.add_missing_imports, "Add missing imports")
		map("<leader>of", M.fix_all, "Fix all")
	end,
})

-- No plugin needed - returning empty table
return {}
