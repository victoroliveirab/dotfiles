return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup({
        disable = {
          filetypes = { "TelescopePrompt" },
        },
      })

      wk.register({
        [";"] = {
          name = "Telescope"
        },
        [" "] = {
          l = {
            name = "LSP",
          },
          s = {
            name = "Window",
          },
          h = {
            name = "Git/Harpoon",
          },
          o = {
            name = "Open Special File",
          },
          w = {
            name = "AutoSession"
          },
        },
      })
    end,
  },
}
