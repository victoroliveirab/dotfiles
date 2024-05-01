local servers = require("victor.constants").servers

local attach_keymaps = function(bufnr)
  local bsk = function(buffer, mode, lhs, rhs, description)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = buffer,
      desc = "LSP: " .. description,
      remap = true,
      silent = true,
    })
  end

  bsk(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration")
  bsk(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition")
  bsk(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition")
  bsk(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
  bsk(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "View Implementations")
  bsk(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "View References")
  bsk(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Diagnostics")
  -- bsk(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "Format (async)")
  bsk(bufnr, "n", "<leader>ln", "<cmd>LspInfo<cr>", "Server(s) Info")
  bsk(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions")
  bsk(bufnr, "n", "<leader>ll", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Diagnostics: prev")
  bsk(bufnr, "n", "<leader>lh", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Diagnostics: next")
  bsk(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
  bsk(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help")
  bsk(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set Local List")
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local bufnr = event.buf
        attach_keymaps(bufnr)
      end
    })

    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "󰠠" },
      { name = "DiagnosticSignInfo", text = "" },
    }
    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local lspconfig = require("lspconfig")
    for _, server in ipairs(servers) do
      local opts = {
        capabilities = capabilities
      }
      server = vim.split(server, "@")[1]
      local has_config, server_config = pcall(require, "victor.lsp.settings." .. server)
      if has_config then
        opts = vim.tbl_deep_extend("force", server_config, opts)
      end
      lspconfig[server].setup(opts)
    end
  end
}
