return {
  "rmagatti/auto-session",
  event = "VeryLazy",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
    })

    vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "AutoSession: Restore session for cwd" }) -- restore last workspace session for current directory
    vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>",
      { desc = "AutoSession: Save session for auto session root dir" })                                             -- save workspace session for current working directory
  end,
}
