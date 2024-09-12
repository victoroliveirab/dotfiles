-- :help options

-- General and Resets
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- Interface
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.showtabline = 1 -- always show tabs
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.colorcolumn = "100"

-- Editing and Searching
vim.opt.autoindent = true
vim.opt.completeopt = { "menuone", "noselect", "preview" } -- mostly just for cmp
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.hlsearch = false -- highlight all matches on previous search pattern
vim.opt.incsearch = true -- show matches while typing
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.scrolloff = 8 -- keep 8 lines clear on vertical scroll
vim.opt.sidescrolloff = 8 -- keep 8 lines clear on horizontal scroll
vim.opt.softtabstop = 2
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
