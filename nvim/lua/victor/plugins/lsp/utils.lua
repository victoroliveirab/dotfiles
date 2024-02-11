local M = {}

M.set_keymaps = function(bufnr)
	local opts = { noremap = true, silent = true }

	local bsk = function(buffer, mode, lhs, rhs, options, description)
		vim.api.nvim_buf_set_keymap(
			buffer,
			mode,
			lhs,
			rhs,
			vim.tbl_deep_extend("force", options, { desc = description })
		)
	end

	bsk(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, "Go to declaration")
	bsk(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, "Go to definition")
	bsk(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts, "Go to type definition")
	bsk(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts, "Hover")
	bsk(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, "View implementations")
	bsk(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, "View references")
	bsk(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, "Open diagnostics")
	bsk(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts, "Format (async)")
	bsk(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts, "LSP info")
	bsk(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts, "Code actions")
	bsk(bufnr, "n", "<leader>ll", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts, "Diagnostics: prev")
	bsk(bufnr, "n", "<leader>lh", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts, "Diagnostics: next")
	bsk(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts, "Rename")
	bsk(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts, "Signature help")
	bsk(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts, "Set local list")
end

return M
