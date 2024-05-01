return {
	{
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			local ufo = require("ufo")
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			vim.keymap.set("n", "zR", ufo.openAllFolds)
			vim.keymap.set("n", "zM", ufo.closeAllFolds)

			ufo.setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				debug = false,
				sources = {
					formatting.prettier,
					formatting.black,
					formatting.stylua,
					diagnostics.eslint,
					diagnostics.flake8,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "VeryLazy",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
				},
				disable_filetype = { "TelescopePrompt" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if not cmp_status_ok then
				return
			end
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<C-/>",
					block = "<C-b>",
				},
				opleader = {
					line = "<C-/>",
					block = "<C-b>",
				},
				mappings = {
					basic = true,
					extra = false,
				},
				pre_hook = function()
					return vim.bo.commentstring
				end,
			})
		end,
	},
	{
		"laytan/tailwind-sorter.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build",
		config = true,
	},
	{
		"victoroliveirab/css-utils.nvim",
		dir = vim.fn.expand("~") .. "/workspaces/personal/css-utils.nvim",
		lazy = true,
		enabled = false,
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- dev = true,
		config = function()
			require("css-utils").setup({
				dev = true,
			})
		end,
	},
}
