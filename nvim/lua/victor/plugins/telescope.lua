return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-node-modules.nvim",
		},
		event = "VeryLazy",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						n = {
							["q"] = actions.close,
							["?"] = actions.which_key,
						},
					},
				},
			})

			telescope.load_extension("node_modules")
			-- telescope.load_extension("advanced_git_search")

			vim.keymap.set("n", ";f", function()
				builtin.find_files({
					no_ignore = false,
					hidden = false,
				})
			end, { desc = "Fuzzy finder" })
			vim.keymap.set("n", ";c", function()
				builtin.live_grep({
					no_ignore = false,
					hidden = false,
					glob_pattern = {
						"!*CHANGELOG*",
						"!yarn.lock",
						"!package-lock.json",
						"!*__fixtures__*",
					},
				})
			end)
			vim.keymap.set("n", ";r", function()
				builtin.live_grep()
			end, { desc = "Live grep" })
			vim.keymap.set("n", ";b", function()
				builtin.buffers()
			end, { desc = "Opened buffers" })
			vim.keymap.set("n", ";t", function()
				builtin.help_tags()
			end, { desc = "Help tags" })
			vim.keymap.set("n", ";;", function()
				builtin.resume()
			end, { desc = "Open last telescope picker" })
			vim.keymap.set("n", ";e", function()
				builtin.diagnostics()
			end, { desc = "Open diagnostics" })
		end,
	},
}
