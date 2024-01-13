local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

treesitter.setup({
	ensure_installed = {
		"bash",
		"css",
		"dockerfile",
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
	},
	ignore_install = { "" },
	highlight = {
		additional_vim_regex_highlighting = { "markdown" },
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				-- print(vim.inspect({ lang = lang, buf = buf, ok = ok, stats = stats, status = "disabled" }))
				return true
			end
			-- print(vim.inspect({ lang = lang, buf = buf, ok = ok, stats = stats, status = "enabled" }))
		end,
	},
	autotag = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	-- rainbow = {
	-- 	enable = true,
	-- 	extended_mode = false,
	-- 	max_file_lines = nil,
	-- },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
