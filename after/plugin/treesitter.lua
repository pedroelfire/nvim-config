require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "javascript", "typescript", "lua", "html", "markdown", "markdown_inline"  },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
