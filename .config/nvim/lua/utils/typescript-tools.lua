-- TypeScript Tools
-- TypeScript/JavaScript tooling with Biome and ts_ls
--
-- Prioritizes Biome LSP when available, falls back to typescript-language-server (ts_ls)
-- Includes import organization, code actions, and formatting via Biome or native LSP
-- Manual commands available under <leader>o for import management

-- TypeScript/JavaScript import management helper
local M = {}

-- Helper to check if a specific LSP client is attached
local function has_client(bufnr, client_name)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = client_name })
	return #clients > 0
end

-- Execute code action with Biome preference or fallback
local function execute_code_action(bufnr, biome_action, fallback_action)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	local action = has_client(bufnr, "biome") and biome_action or fallback_action
	
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { action },
			diagnostics = {},
		},
	})
end

-- Execute TypeScript-specific command via ts_ls
local function execute_ts_command(bufnr, command)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
	if #clients == 0 then
		vim.notify("ts_ls client not attached", vim.log.levels.WARN)
		return
	end
	
	local params = {
		command = command,
		arguments = { vim.api.nvim_buf_get_name(bufnr) },
	}
	
	clients[1].request("workspace/executeCommand", params, function(err, result)
		if err then
			vim.notify("Error executing " .. command .. ": " .. vim.inspect(err), vim.log.levels.ERROR)
		end
	end, bufnr)
end

-- Organize imports using Biome or native LSP
M.organize_imports = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	if has_client(bufnr, "biome") then
		execute_code_action(bufnr, "source.organizeImports.biome", "source.organizeImports")
	elseif has_client(bufnr, "ts_ls") then
		execute_ts_command(bufnr, "_typescript.organizeImports")
	else
		vim.notify("No LSP client (biome or ts_ls) attached", vim.log.levels.WARN)
	end
end

-- Sort imports using Biome or native LSP
M.sort_imports = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	if has_client(bufnr, "biome") then
		-- Biome handles sorting through organize imports
		execute_code_action(bufnr, "source.organizeImports.biome", "source.organizeImports")
	elseif has_client(bufnr, "ts_ls") then
		execute_ts_command(bufnr, "_typescript.sortImports")
	else
		vim.notify("No LSP client (biome or ts_ls) attached", vim.log.levels.WARN)
	end
end

-- Remove unused imports using code actions (Biome preferred)
M.remove_unused_imports = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	execute_code_action(bufnr, "quickfix.biome", "source.removeUnused")
end

-- Add missing imports using code actions
M.add_missing_imports = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	-- Both Biome and ts_ls support this action with the same name
	execute_code_action(bufnr, "source.addMissingImports", "source.addMissingImports")
end

-- Fix all fixable errors (Biome preferred)
M.fix_all = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	execute_code_action(bufnr, "source.fixAll.biome", "source.fixAll")
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
