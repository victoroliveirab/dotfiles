local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	return
end

local config_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	open_on_tab = true,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		width = 30,
		hide_root_folder = true,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
		expand_all = {
			exclude = {
				".git",
				"target",
				"build",
				"dist",
				"node_modules",
			},
		},
	},
})
