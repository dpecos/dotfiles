-- Mason Tool Installer
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--
-- Automatically install and manage LSP servers, formatters, and linters via Mason

local mason_tools = require("plugins/local/mason-tools")

local function tools_to_autoinstall(servers, formatters, linters)
	local servers_list   = vim.iter(vim.tbl_keys(servers)):flatten():totable()
	local formatters_list = vim.iter(vim.tbl_values(formatters)):flatten():totable()
	local linters_list   = vim.iter(vim.tbl_values(linters)):flatten():totable()

	local tools = servers_list
	tools = vim.list_extend(tools, formatters_list)
	tools = vim.list_extend(tools, linters_list)

	table.sort(tools)
	tools = vim.fn.uniq(tools)

	return tools
end

local tools_to_install = tools_to_autoinstall(mason_tools.servers, mason_tools.formatters, mason_tools.linters)
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = tools_to_install,
})
