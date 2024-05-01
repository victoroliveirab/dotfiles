local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,
  version = "*",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      on_attach = on_attach,
      view = {
        width = 35,
        relativenumber = true,
        side = "left",
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file tree" }) -- toggle file explorer on current file
  end
}
