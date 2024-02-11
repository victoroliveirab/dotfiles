local path_to_vault = vim.fn.expand("~") .. "obsnotes"

return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = {
			string.format("BufReadPre %s/**.md", path_to_vault),
			string.format("BufNewFile %s/**.md", path_to_vault),
		},
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			daily_notes = {},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
				new_notes_location = "current_dir",
				prepend_note_id = true,
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
			overwrite_mappings = false,
			templates = {
				subdir = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},
			backlinks = {
				height = 10,
				wrap = true,
			},
			finder = "telescope.nvim",
			open_notes_in = "current",
		},
	},
}
