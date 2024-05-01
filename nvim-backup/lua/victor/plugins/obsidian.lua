local path_to_vault = vim.fn.expand("~") .. "/obsnotes"

--			string.format("BufReadPre %s/**.md", path_to_vault),
--			string.format("BufNewFile %s/**.md", path_to_vault),

return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			workspaces = {
				{
					name = "obsnotes",
					path = path_to_vault,
				},
			},
			daily_notes = {},
			new_notes_location = "current_dir",
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			mappings = {
				["gf"] = {
					action = function()
						local obsidian = require("obsidian")
						if obsidian.util.cursor_on_markdown_link() then
							return obsidian.util.gf_passthrough()
						end
						-- NOTE: not sure if this works
						return "gf"
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},
			templates = {
				subdir = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {
					git_branch = function()
						local name = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
						if not name then
							return ""
						end
						return name
					end,
				},
			},
			finder = "telescope.nvim",
			open_notes_in = "current",
		},
	},
}
