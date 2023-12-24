local servers = {
	"cssls",
  "gopls",
	"html",
	"jsonls",
	"pyright",
	"lua_ls",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("neodev").setup({})

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("victor.lsp.handlers").on_attach,
		capabilities = require("victor.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local has_config, server_config = pcall(require, "victor.lsp.settings." .. server)
	if has_config then
		opts = vim.tbl_deep_extend("force", server_config, opts)
	end

	if server == "tsserver" then
		local ext = {
			root_dir = lspconfig.util.root_pattern("yarn.lock", "package-lock.json", "lerna.json", ".git"),
		}
		opts = vim.tbl_deep_extend("force", ext, opts)
	end

	lspconfig[server].setup(opts)
end
