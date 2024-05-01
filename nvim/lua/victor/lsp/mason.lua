local servers = require("victor.constants").servers

return {
		"williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
		config = function()
			require("mason").setup({
				ui = {
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
}
