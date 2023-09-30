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

	-- cmp
	use({ "hrsh7th/nvim-cmp", commit = "e7e2ef7031db8e0cfad7ad9916ec766ddd9dbb3b" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "hrsh7th/cmp-cmdline", commit = "23c51b2a3c00f6abc4e922dbd7c3b9aca6992063" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "663d54482b11bca1ce94f56993b9f6ab485a13dc" })
	-- use({ "rafamadriz/friendly-snippets", commit = "fd16b4d9dc58119eeee57e9915864c4480d591fd" })

	-- lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use("folke/neodev.nvim")

	-- null-ls
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "c3e678110d5f31854c6575cf4bda3b82f3d4a884" })

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", commit = "d9be302f7499c203ab274bc2b37f11150a2f8834" })
	use({ "windwp/nvim-ts-autotag", commit = "fdefe46c6807441460f11f11a167a2baf8e4534b" })
	-- use { "m-demare/hlargs.nvim", config = function() require("hlargs").setup() end }

	-- editor-related
	use({
		"nvim-telescope/telescope.nvim",
		commit = "203bf5609137600d73e8ed82703d6b0e320a5f36",
		requires = {
			"nvim-telescope/telescope-node-modules.nvim",
		},
	})
	use({ "kyazdani42/nvim-tree.lua", commit = "02fdc262eba188198a7deb2117b3b996e6763d65" }) -- file tree
	use({ "folke/which-key.nvim", commit = "684e96c5e8477f1ee9b3f2e9a12d802fd12c5531" }) -- keymaps cheatsheet
	use({ "numToStr/Comment.nvim", commit = "eab2c83a0207369900e92783f56990808082eac2" }) -- comment code
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "2941f0064874b33e93d3a794a8a4e99f5f6ece56",
		after = "nvim-treesitter",
	}) -- comment jsx code
	use({ "szw/vim-maximizer", commit = "2e54952fe91e140a2e69f35f22131219fcd9c5f1" }) -- maximize one opened window
	use({ "windwp/nvim-autopairs", commit = "03580d758231956d33c8dd91e2be195106a79fa4" }) -- parentheses and such autopair
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
	use({ "ThePrimeagen/harpoon", commit = "21f4c47c6803d64ddb934a5b314dcb1b8e7365dc" })
	use({
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup({
				-- options
			})
		end,
	})
	use({ "seandewar/killersheep.nvim" })
	use({ "victoroliveirab/requests.nvim" })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
