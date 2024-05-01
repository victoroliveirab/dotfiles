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

-- Window
set_keymap("n", "<leader>sv", ":vsplit<CR>", "Split Vertically")
set_keymap("n", "<leader>sh", ":split<CR>", "Split Horizontally")
set_keymap("n", "<leader>sw", ":close<CR>", "Close Window")
set_keymap("n", "<C-h>", ":wincmd h<CR>", "Go to Left Window")
set_keymap("n", "<C-l>", ":wincmd l<CR>", "Go to Right Window")
set_keymap("n", "<C-j>", ":wincmd j<CR>", "Go to Window Below")
set_keymap("n", "<C-k>", ":wincmd k<CR>", "Go to Window Above")

-- Indent
set_keymap("v", "<", "<gv")
set_keymap("v", ">", ">gv")

-- Do not yank with x
set_keymap("n", "x", '"_x')

-- Resizing Panels
set_keymap("n", "<Left>", ":vertical resize +1<CR>")
set_keymap("n", "<Right>", ":vertical resize -1<CR>")
set_keymap("n", "<Up>", ":resize -1<CR>")
set_keymap("n", "<Down>", ":resize +1<CR>")
