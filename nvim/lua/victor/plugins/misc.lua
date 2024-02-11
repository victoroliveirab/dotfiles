return {
	{
		"victoroliveirab/requests.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("requests").setup({
				default_queries = {
					"results:3",
					"gender:male",
					"password:upper,lower,9-16",
					"nat:br",
					"exc:picture",
				},
				default_url = "https://randomuser.me/api/",
				keymap = "<leader>r",
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		event = "VeryLazy",
		enabled = false,
		config = function()
			local harpoon_mark = require("harpoon.mark")
			local harpoon_ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
			vim.keymap.set("n", "\\\\", harpoon_ui.toggle_quick_menu)

			-- vim.api.nvim_set_keymap("n", "<A-,>", "<Cmd>CybuLastusedPrev<CR>", { silent = true })
			-- vim.keymap.set("n", "<A-.>", harpoon_ui.nav_next)
			vim.keymap.set("n", "<A-1>", function()
				harpoon_ui.nav_file(1)
			end)
			vim.keymap.set("n", "<A-2>", function()
				harpoon_ui.nav_file(2)
			end)
			vim.keymap.set("n", "<A-3>", function()
				harpoon_ui.nav_file(3)
			end)
			vim.keymap.set("n", "<A-4>", function()
				harpoon_ui.nav_file(4)
			end)
		end,
	},
}
