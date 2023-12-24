-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local on_attach = function (bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  disable_netrw = true,
  hijack_netrw = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 30,
    side = "left",
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
    expand_all = {
      exclude = {
        ".git",
        "target",
        "build",
        "dist",
        "node_modules",
      }
    }
  }
})
