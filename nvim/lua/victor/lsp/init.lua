local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

require("victor.lsp.mason")
require("victor.lsp.handlers").setup()
require("victor.lsp.null-ls")
