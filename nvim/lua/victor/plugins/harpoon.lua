return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  config = function()
    local harpoon_mark = require("harpoon.mark")
    local harpoon_ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", harpoon_mark.add_file, { desc = "Harpoon: Add File" })
    vim.keymap.set("n", "<leader>hm", harpoon_ui.toggle_quick_menu, { desc = "Harpoon: Toggle Quick Menu" })

    for i = 1, 9, 1 do
      vim.keymap.set("n", "<A-" .. tostring(i) .. ">", function()
        harpoon_ui.nav_file(i)
      end)
    end
  end
}
