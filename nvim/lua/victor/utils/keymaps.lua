local keymap = vim.api.nvim_set_keymap
local buffer_keymap = vim.api.nvim_buf_set_keymap

local extend_opts = function(opts, description)
	local options = opts
	if type(description) == "string" then
		options = vim.tbl_deep_extend("force", options, { desc = description })
	end
	return options
end

return {
	set = function(mode, lhs, rhs, options, description)
		keymap(mode, lhs, rhs, extend_opts(options, description))
	end,
	buffer_set = function(buffer, mode, lhs, rhs, options, description)
		buffer_keymap(buffer, mode, lhs, rhs, extend_opts(options, description))
	end,
}
