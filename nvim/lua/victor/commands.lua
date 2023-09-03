local close_buffers_except_current = function()
	local curr_buf = vim.api.nvim_get_current_buf()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		if buf ~= curr_buf then
			pcall(vim.api.nvim_buf_delete, buf, { force = false })
		end
	end
end

local force_treesitter_reparse = function()
	-- TODO: change -1 to the treesitter namespace => find out
	vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)
	vim.cmd("write | edit | TSBufEnable highlight")
end

return {
	close_buffers_except_current = close_buffers_except_current,
	force_treesitter_reparse = force_treesitter_reparse,
}
