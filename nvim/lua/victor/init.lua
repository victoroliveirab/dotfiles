require("victor.base")
require("victor.keymaps")
require("victor.commands")
require("lazy").setup({
  { import = "victor.plugins" },
  { import = "victor.lsp" },
})
