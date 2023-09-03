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
})
