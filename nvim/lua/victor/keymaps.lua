---@param mode string
---@param lhs string
---@param rhs string
---@param description? string
local set_keymap = function(mode, lhs, rhs, description)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { desc = description, noremap = true, silent = true })
end

set_keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Netrw
set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", "Toggle File Tree")

-- Tabs and Windows
set_keymap("n", "<leader>sv", ":vsplit<CR>", "Split vertically")
set_keymap("n", "<leader>sh", ":split<CR>", "Split horizontally")
set_keymap("n", "<leader>sw", ":close<CR>", "Close window (close split)")
set_keymap("n", "<leader>sx", ":bp | sp | bn | bd<CR>", "Close Buffer (keep split)")
set_keymap("n", "<leader>sb", ":bd<CR>", "Close buffer (close split)")
set_keymap("n", "<leader>sm", ":MaximizerToggle<CR>", "Maximize/minimize window")
set_keymap(
	"n",
	"<leader>sA",
	"<Cmd>lua require('victor.commands').close_buffers_except_current()<CR>",
	"Close all buffers except current"
)
set_keymap("n", "<C-h>", ":wincmd h<CR>", "Go to left window")
set_keymap("n", "<C-l>", ":wincmd l<CR>", "Go to right window")
set_keymap("n", "<C-j>", ":wincmd j<CR>", "Go to window below")
set_keymap("n", "<C-k>", ":wincmd k<CR>", "Go to window above")

-- Better indent
set_keymap("v", "<", "<gv")
set_keymap("v", ">", ">gv")

-- Do not yank with x
set_keymap("n", "x", '"_x')

-- Move text up and down
set_keymap("n", "<A-j>", ":m .+1<CR>==")
set_keymap("n", "<A-k>", ":m .-2<CR>==")
set_keymap("v", "<A-j>", ":m .+1<CR>==")
set_keymap("v", "<A-k>", ":m .-2<CR>==")
set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")
set_keymap("v", "p", '"_dP')

-- Resizing Panels
set_keymap("n", "<Left>", ":vertical resize +1<CR>")
set_keymap("n", "<Right>", ":vertical resize -1<CR>")
set_keymap("n", "<Up>", ":resize -1<CR>")
set_keymap("n", "<Down>", ":resize +1<CR>")

-- cmp
set_keymap("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

-- general
set_keymap("n", "<leader>tg", "<Cmd>!/usr/bin/gedit % & disown ;<CR>", "Open current file on gedit")
set_keymap("n", "<leader>tr", "<Cmd>lua require('victor.commands').force_treesitter_reparse()<CR>")
set_keymap("n", "<leader>dl", "<Cmd>lua require('victor.commands').clear_log_file()<CR>")
set_keymap(
	"n",
	"<leader>hD",
	"<Cmd>Telescope advanced_git_search diff_commit_file<CR>",
	"Open commit history for current file"
)
vim.keymap.set("n", "<leader>oe", function()
	local cwd = vim.fn.getcwd()
	local possible_files = {
		".env.development.local",
		".env.local",
		".env.development",
		".env",
	}
	---@type string?
	local filename
	for _, f in ipairs(possible_files) do
		local fsize = vim.fn.getfsize(string.format("%s/%s", cwd, f))
		if fsize ~= -1 then
			filename = f
			break
		end
	end
	if not filename then
		error("No .env or variant found", 2)
	end
	vim.cmd(string.format(":e %s", filename))
end, { desc = "Open env file" })
vim.keymap.set("n", "<leader>op", function()
	local cwd = vim.fn.getcwd()
	local possible_files = {
		"package.json",
		"requirements.txt",
		"Cargo.toml",
		"mix.exs",
	}
	---@type string?
	local filename
	for _, f in ipairs(possible_files) do
		local fsize = vim.fn.getfsize(string.format("%s/%s", cwd, f))
		if fsize ~= -1 then
			filename = f
			break
		end
	end
	if not filename then
		error("No .env or variant found", 2)
	end
	vim.cmd(string.format(":e %s", filename))
end, { desc = "Open package file" })
