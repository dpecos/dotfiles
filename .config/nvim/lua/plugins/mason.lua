local mason_tools = require("plugins/local/mason-tools")

local function tools_to_autoinstall(servers, formatters, linters)
	local servers_list = vim.tbl_flatten(vim.tbl_keys(servers))
	local formatters_list = vim.tbl_flatten(vim.tbl_values(formatters))
	local linters_list = vim.tbl_flatten(vim.tbl_values(linters))

	local tools = servers_list
	tools = vim.list_extend(tools, formatters_list)
	tools = vim.list_extend(tools, linters_list)

	-- only unique tools
	table.sort(tools)
	tools = vim.fn.uniq(tools)

	return tools
end

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local tools_to_install = tools_to_autoinstall(mason_tools.servers, mason_tools.formatters, mason_tools.linters)
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = tools_to_install,
		})
	end,
}
