local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" } -- Have packer manage itself
  use { "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" } -- An implementation of the Popup API from vim in Neovim
  use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" } -- Useful lua functions used ny lots of plugins
  use { "kyazdani42/nvim-web-devicons", commit = "a8cf88cbdb5c58e2b658e179c4b2aa997479b3da" } -- devicons

  -- Colorscheme
  use { "folke/tokyonight.nvim", commit = "e6307e12ebe8487d17ec87fe14c3972c21466139" }

  -- tmux
  use { "christoomey/vim-tmux-navigator", commit = "c2dab181185101070b0ad6c33451f4e2f56a446a" }

  -- Statusline
  use { "nvim-lualine/lualine.nvim", commit = "edca2b03c724f22bdc310eee1587b1523f31ec7c" }

  -- cmp
  use { "hrsh7th/nvim-cmp", commit = "3347dd3c59b6c62288d861ddb92b9ba1227257a8" } -- main plugin
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions 
  use { "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" } -- path completions 
  use { "hrsh7th/cmp-cmdline", commit = "c66c379915d68fb52ad5ad1195cdd4265a95ef1e" } -- cmdline completions
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" } -- cmp and lsp together
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" } -- nvim completions

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "663d54482b11bca1ce94f56993b9f6ab485a13dc" }
  use { "rafamadriz/friendly-snippets", commit = "fd16b4d9dc58119eeee57e9915864c4480d591fd" }

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "35a731bddaf20be0a2a0492cfa489ae6130a4eb6" }
  use { "williamboman/mason.nvim", commit = "45b9a4da776d9fb017960b3ac7241161fb7bc578" }
  use { "williamboman/mason-lspconfig.nvim", commit = "bf8ac1221aed7d61abc646cffb5450b1aca31d39" }
  use { "glepnir/lspsaga.nvim", commit = "85e1c00f5a6645b0571d475b4b43803377a82bf0" }
  -- use { "jose-elias-alvarez/typescript.nvim", commit = "0c7d908ef7760dbca586ed7a7660d224406b1eab" } -- not sure why not working

  -- File browsing
  use { "nvim-telescope/telescope.nvim", commit = "f174a0367b4fc7cb17710d867e25ea792311c418" }
  use { "nvim-telescope/telescope-file-browser.nvim", commit = "6b4e22777bfa6a31787a4ac8e086b062ef241ede" }
  -- TODO: find out why this won't work
  -- use { "nvim-tree/nvim-tree.lua", commit = "cc18122be1c53e6736f4f7a75a32429b3bbca2a0" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac", run = ":TSUpdate" }
  use { "m-demare/hlargs.nvim", commit = "a8667203cf947f89c5303016614fac67f3f691a0", config = function() require("hlargs").setup() end }

  -- Editor
  use { "numToStr/Comment.nvim", commit = "ad7ffa8ed2279f1c8a90212c7d3851f9b783a3d6" }
  use {"JoosepAlviste/nvim-ts-context-commentstring", commit = "2941f0064874b33e93d3a794a8a4e99f5f6ece56", after = 'nvim-treesitter' }
  use { "romgrk/barbar.nvim", commit = "68a2751728f9ab3d3510f0fe9165a2a451aa8727" }
  use { "szw/vim-maximizer", commit = "2e54952fe91e140a2e69f35f22131219fcd9c5f1" }

  -- Formatting
  -- use { "jose-elias-alvarez/null-ls.nvim", commiit = "9c19fb55154e53dadb986d5aceed1c53e3131b35" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


