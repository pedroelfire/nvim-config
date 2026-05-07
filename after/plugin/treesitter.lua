require("nvim-treesitter.configs").setup({

	ensure_installed = { "python", "lua", "javascript", "typescript", "go", "html", "markdown" },

	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})
