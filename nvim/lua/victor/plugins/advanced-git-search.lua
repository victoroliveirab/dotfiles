return {
  "aaronhallaert/advanced-git-search.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim", "tpope/vim-fugitive" },
  config = function()
    require("telescope").setup({
      extensions = {
        advanced_git_search = {
          diff_plugin = "fugitive",
          show_builtins_git_pickers = false,
        },
      },
    })
  end,
  keys = {
    { "<leader>hD", "<cmd>Telescope advanced_git_search diff_commit_file<cr>", "Git: Open Commit History for Current File" }
  }
}
