local lsp_utils = require("victor.plugins.lsp.utils")

local servers = {
	"astro",
	"clangd",
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

local on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_utils.set_keymaps(bufnr)
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = false,
				signs = { active = signs },
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

			local lspconfig = require("lspconfig")

			for _, server in pairs(servers) do
				local opts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}
				server = vim.split(server, "@")[1]
				local has_config, server_config = pcall(require, "victor.plugins.lsp.settings." .. server)
				if has_config then
					opts = vim.tbl_deep_extend("force", server_config, opts)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
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
			})
      require("mason-lspconfig").setup({
        ensured_installed = servers,
        automatic_installation = true,
      })
		end,
	},
}
