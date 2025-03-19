vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use{ 'nvim-telescope/telescope.nvim', tag = '0.1.8',
	requires = { {'nvim-lua/plenary.nvim'} }
}
use({ 'rose-pine/neovim', as = 'rose-pine', config = function() vim.cmd('colorscheme rose-pine') end })
use({ "ellisonleao/gruvbox.nvim", as = 'gruvbox', config = function() vim.cmd('colorscheme gruvbox') end})
use({ "folke/tokyonight.nvim", as = 'tokyonight', config = function() vim.cmd('colorscheme tokyonight') end})
use('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})
use('theprimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')
use ({
  "kylechui/nvim-surround",
  tag = "*", -- Usa la última versión estable
  config = function()
    require("nvim-surround").setup({})
  end
})
use({
  "utilyre/barbecue.nvim",
  tag = "*",
  requires = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  }
})
use ({
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v1.x',
	requires = {
		{'neovim/nvim-lspconfig'},             -- Required
		{'williamboman/mason.nvim'},           -- Optional
		{'williamboman/mason-lspconfig.nvim'}, -- Optional
		{'hrsh7th/nvim-cmp'},         -- Required
		{'hrsh7th/cmp-nvim-lsp'},     -- Required
		{'hrsh7th/cmp-buffer'},       -- Optional
		{'hrsh7th/cmp-path'},         -- Optional
		{'saadparwaiz1/cmp_luasnip'}, -- Optional
		{'hrsh7th/cmp-nvim-lua'},     -- Optional
		{'L3MON4D3/LuaSnip'},             -- Required
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'saadparwaiz1/cmp_luasnip'},
		{'rafamadriz/friendly-snippets'}, -- Optional
	}
})
use({
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  requires = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  }
})
end)

