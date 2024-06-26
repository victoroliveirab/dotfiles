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

      -- General Pickers
			vim.keymap.set("n", ";f", function()
				builtin.find_files({
					no_ignore = false,
					hidden = false,
				})
			end, { desc = "Fuzzy finder" })

			vim.keymap.set("n", ";r", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", ";b", builtin.buffers, { desc = "Opened buffers" })
			vim.keymap.set("n", ";t", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", ";;", builtin.resume, { desc = "Open last telescope picker" })
			vim.keymap.set("n", ";e", builtin.diagnostics, { desc = "Open diagnostics" })

      -- Specialized greps
			vim.keymap.set("n", ";gf", function()
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
			end, { desc = "Grep from important files"})

      vim.keymap.set("n", ";gc", function ()
       builtin.live_grep({
          search_dirs = {
            "cypress"
          }
        })
      end, { desc = "Grep from cypress-related files" })

		end,
	},
}
