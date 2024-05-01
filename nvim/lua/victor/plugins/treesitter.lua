local languages = {
	"astro",
	"bash",
	"css",
	"dockerfile",
	"go",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"prisma",
	"python",
	"rust",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = languages,
				ignore_install = { "" },
				highlight = {
					additional_vim_regex_highlighting = { "markdown" },
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				autotag = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
		build = ":TSUpdate",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
