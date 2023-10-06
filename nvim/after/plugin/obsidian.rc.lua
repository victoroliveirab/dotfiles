local ok, obsidian = pcall(require, "obsidian")
if not ok then
	return
end

obsidian.setup({
	daily_notes = {},
	dir = "~/obsnotes",
	completion = {
		nvim_cmp = true,
		min_chars = 2,
		new_notes_location = "current_dir",
		prepend_note_id = true,
	},
	mappings = {},
	overwrite_mappings = false,
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		-- A map for custom variables, the key should be the variable and the value a function
		substitutions = {},
	},
	-- Optional, customize the backlinks interface.
	backlinks = {
		-- The default height of the backlinks pane.
		height = 10,
		-- Whether or not to wrap lines.
		wrap = true,
	},
	finder = "telescope.nvim",
	open_notes_in = "current",
})

vim.keymap.set("n", "gf", function()
	if obsidian.util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })
