return {
	{
		"folke/which-key.nvim",
		lazy = false,
		config = function()
			local wk = require("which-key")
			wk.setup({
				disable = {
					filetypes = { "TelescopePrompt" },
				},
			})

			wk.register({
				g = {
					D = "Go to Declaration",
					d = "Go to Definition",
					I = "Implementations",
					r = "References",
					l = "Open diagnostics",
				},
				[" "] = {
					l = {
						name = "LSP",
					},
					s = {
						name = "Window",
					},
					h = {
						name = "Git",
					},
					o = {
						name = "Open special file",
					},
				},
				-- [" "] = {
				-- 	l = {
				-- 		f = "Format async",
				-- 		i = "Lsp info",
				-- 		a = "Code actions",
				-- 		j = "Diagnostics: next",
				-- 		k = "Diagnostics: prev",
				-- 		r = "Rename",
				-- 		s = "Signature help",
				-- 	},
				-- },
			})
		end,
	},
	{
		"folke/neodev.nvim",
	},
}
