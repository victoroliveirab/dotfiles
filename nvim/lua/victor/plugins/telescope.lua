return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-node-modules.nvim",
		},
		event = "VeryLazy",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						n = {
							["q"] = actions.close,
							["?"] = actions.which_key,
						},
					},
				},
			})

			telescope.load_extension("node_modules")

      -- General Pickers
			vim.keymap.set("n", ";f", function()
				builtin.find_files({
					no_ignore = false,
					hidden = false,
				})
			end, { desc = "Fuzzy finder" })

			vim.keymap.set("n", ";r", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", ";b", builtin.buffers, { desc = "Opened buffers" })
			vim.keymap.set("n", ";t", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", ";;", builtin.resume, { desc = "Open last telescope picker" })
			vim.keymap.set("n", ";e", builtin.diagnostics, { desc = "Open diagnostics" })

      -- Specialized greps
			vim.keymap.set("n", ";gf", function()
				builtin.live_grep({
					no_ignore = false,
					hidden = false,
					glob_pattern = {
						"!*CHANGELOG*",
						"!yarn.lock",
						"!package-lock.json",
						"!*__fixtures__*",
					},
				})
			end, { desc = "Grep from important files"})

      vim.keymap.set("n", ";gc", function ()
       builtin.live_grep({
          search_dirs = {
            "cypress"
          }
        })
      end, { desc = "Grep from cypress-related files" })

		end,
	},
  {
    "axkirillov/easypick.nvim",
    event = "VeryLazy",
    dependencies = {  
      "nvim-telescope/telescope.nvim",
    },
    config = function() 
      local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
      local base_branch = vim.fn.system(get_default_branch) or "main"
      local easypick = require("easypick")
      easypick.setup({
        pickers = {
          -- diff current branch with base_branch and show files that changed with respective diffs in preview
          {
            name = "changed_files",
            command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
            previewer = easypick.previewers.branch_diff({base_branch = base_branch})
          },
          -- list files that have conflicts with diffs in preview
          {
            name = "conflicts",
            command = "git diff --name-only --diff-filter=U --relative",
            previewer = easypick.previewers.file_diff()
          },
	      }
      })

      vim.keymap.set("n", "<leader>hf", "<cmd>Easypick changed_files<cr>", {
        desc = "Open Git Changed Files",
      })
      vim.keymap.set("n", "<leader>hc", "<cmd>Easypick conflicts<cr>", {
        desc = "Open Git Conflicted Files",
      })
    end,
  }
}
