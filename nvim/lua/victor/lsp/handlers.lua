local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local set_buffer_keymap = require("victor.utils.keymaps").buffer_set

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

-- Adapted from: https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/definition.lua
local textDocument_definition = function(_, result, method)
	if not method or vim.tbl_isempty(method) then
		return
	end

	local res = {}

	if type(result[1]) == "table" then
		res.uri = result[1].uri or result[1].targetUri
		res.range = result[1].range or result[1].targetSelectionRange
	else
		res.uri = result.uri or method.targetUri
		res.range = result.range or method.targetSelectionRange
	end

	if vim.tbl_isempty(res) then
		return
	end

	local jump_destination = vim.uri_to_fname(res.uri)
	local current_buffer = vim.api.nvim_buf_get_name(0)

	-- if the current buffer is the jump destination and it has been modified
	-- then write the changes first.
	-- this is needed because if the definition is in the current buffer the
	-- jump may not go to the right place.
	if vim.bo.modified and current_buffer == jump_destination then
		vim.cmd("write!")
	end

	vim.api.nvim_command("edit " .. jump_destination)

	vim.api.nvim_win_set_cursor(0, { res.range.start.line + 1, res.range.start.character })
end

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/definition"] = textDocument_definition
	--[[
  IDEAS:
  get windows positions with vim.api.nvim_win_get_position and vim.api.nvim_list_wins
  check if there's more than one window opened, if it is, open the definition to the window which the definition was fired (with gv or whatever, gd remains the same)
  if it is not, open a new vertical split with the definition
  we can also have a command which forcefully opens a new vertical (or horizontal if we want) split
  -- Refs:
  -- https://www.reddit.com/r/neovim/comments/ya4up3/go_to_definition_in_split_view
  -- https://vi.stackexchange.com/questions/42123/shortcut-to-open-definition-of-variable-in-a-vertical-split-with-neovim-mapping/42124#42124
  -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/handlers.lua
  -- https://www.reddit.com/r/neovim/comments/qva6s0/how_do_i_make_lspbufhover_information_goto_a/
  --]]
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	set_buffer_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, "Go to declaration")
	set_buffer_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, "Go to definition")
	set_buffer_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts, "Go to type definition")
	set_buffer_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts, "Hover")
	set_buffer_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, "View implementations")
	set_buffer_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, "View references")
	set_buffer_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, "Open diagnostics")
	set_buffer_keymap(
		bufnr,
		"n",
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
		opts,
		"Format (async)"
	)
	set_buffer_keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts, "LSP info")
	set_buffer_keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts, "Code actions")
	set_buffer_keymap(
		bufnr,
		"n",
		"<leader>ll",
		"<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
		opts,
		"Diagnostics: prev"
	)
	set_buffer_keymap(
		bufnr,
		"n",
		"<leader>lh",
		"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
		opts,
		"Diagnostics: next"
	)
	set_buffer_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts, "Rename")
	set_buffer_keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts, "Signature help")
	set_buffer_keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts, "Set local list")
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		vim.notify("TSServer started", vim.log.levels.INFO)
	end

	if client.name == "lua_ls" then
		-- TODO: add my custom types to the global table
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
