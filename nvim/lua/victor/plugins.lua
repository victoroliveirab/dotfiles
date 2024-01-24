local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
	augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

local ok, packer = pcall(require, "packer")
if not ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })

	-- colorschemes
	use({ "folke/tokyonight.nvim" })

	-- statusline
	use({ "nvim-lualine/lualine.nvim" })

	use({
		"epwalsh/obsidian.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- cmp
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "onsails/lspkind.nvim" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "663d54482b11bca1ce94f56993b9f6ab485a13dc" })
	-- use({ "rafamadriz/friendly-snippets", commit = "fd16b4d9dc58119eeee57e9915864c4480d591fd" })

	-- lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use("folke/neodev.nvim")

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/playground" })
	use({ "windwp/nvim-ts-autotag" })
	-- use { "m-demare/hlargs.nvim", config = function() require("hlargs").setup() end }

	-- editor-related
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-telescope/telescope-node-modules.nvim",
		},
	})
	use({ "kyazdani42/nvim-tree.lua", commit = "7e5c6731804bd892ace56692784290d2fc5a0f74" })
	use({ "folke/which-key.nvim", commit = "684e96c5e8477f1ee9b3f2e9a12d802fd12c5531" }) -- keymaps cheatsheet
	use({ "numToStr/Comment.nvim", commit = "eab2c83a0207369900e92783f56990808082eac2" }) -- comment code
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "2941f0064874b33e93d3a794a8a4e99f5f6ece56",
		after = "nvim-treesitter",
	}) -- comment jsx code
	use({ "szw/vim-maximizer", commit = "2e54952fe91e140a2e69f35f22131219fcd9c5f1" }) -- maximize one opened window
	use({ "windwp/nvim-autopairs" }) -- parentheses and such autopair
	use({ "stevearc/conform.nvim", commit = "37d036704a100ef6e6457be45b4dfc2f8e429572" })
	use({ "mfussenegger/nvim-lint", commit = "1065763f115a7765ef237347ad676ba348d7193a" })
	use({
		"lewis6991/gitsigns.nvim",
		commit = "ec4742a7eebf68bec663041d359b95637242b5c3",
	})
	use({ "tpope/vim-fugitive" })
	use({
		"aaronhallaert/advanced-git-search.nvim",
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
	})
	use({
		"alvarosevilla95/luatab.nvim",
		config = function()
			require("luatab").setup()
		end,
	})
	use({
		"kevinhwang91/nvim-ufo",
		commit = "9e829d5cfa3de6a2ff561d86399772b0339ae49d",
		requires = "kevinhwang91/promise-async",
	}) -- code folding
	-- use({ "ThePrimeagen/harpoon", commit = "21f4c47c6803d64ddb934a5b314dcb1b8e7365dc" })
	-- use({
	-- 	"j-hui/fidget.nvim",
	-- 	tag = "legacy",
	-- 	config = function()
	-- 		require("fidget").setup({
	-- 			-- options
	-- 		})
	-- 	end,
	-- })
	-- use({ "rcarriga/nvim-notify" })
	use({ "seandewar/killersheep.nvim" })
	use({ "victoroliveirab/requests.nvim" })
	use({
		"/Users/victoroliveirab/workspaces/personal/css-utils.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("css-utils").setup({
				dev = true,
			})
		end,
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
