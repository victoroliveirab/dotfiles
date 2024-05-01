return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function ()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd([[colorscheme catppuccin]])
    end
  }
}
