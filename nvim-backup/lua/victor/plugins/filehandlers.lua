local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
	{
		"kyazdani42/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				on_attach = on_attach,
				disable_netrw = true,
				hijack_netrw = true,
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
					side = "left",
				},
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
			})
		end,
	},
}
