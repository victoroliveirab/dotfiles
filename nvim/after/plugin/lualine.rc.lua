local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "dracula",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"NvimTree",
		},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {},
		lualine_c = { { "filename", file_status = true, path = 1 }, "diff" },
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", file_status = true, path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_b = {
			"branch",
		},
		lualine_z = { "tabs" },
	},
	winbar = {
		lualine_a = {
			"mode",
		},
		lualine_c = {
			{ "filename", file_status = true, path = 1 },
		},
	},
	inactive_winbar = {
		lualine_c = {
			{ "filename", file_status = true, path = 1 },
			"diff",
		},
	},
	extensions = { "fugitive" },
})
