vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use{ 'nvim-telescope/telescope.nvim', tag = '0.1.8',
	requires = { {'nvim-lua/plenary.nvim'} }
}
use({ 'rose-pine/neovim', as = 'rose-pine'})
use({ 'sainnhe/gruvbox-material', 
  as = 'gruvbox-material', 
  config = function() vim.cmd('colorscheme gruvbox-material') end
})
use('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})
use('theprimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')
use (
  "tpope/vim-surround"
)
use({
  "utilyre/barbecue.nvim",
  tag = "*",
  requires = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  after = "nvim-web-devicons"
})
  use {'williamboman/mason.nvim'}
  use {'williamboman/mason-lspconfig.nvim'}
  use {'neovim/nvim-lspconfig'}
  
  -- Autocompletado
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {'rafamadriz/friendly-snippets'}
end)

