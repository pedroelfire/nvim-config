-- Configuración LSP para Neovim 0.11
local lsp = require('lspconfig')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')

-- Configurar Mason
mason.setup()
mason_lsp.setup({
  ensure_installed = {
    'eslint',
    'angularls',
    'html',
    'astro',
    'ast_grep'
  }
})

-- Configurar los servidores LSP
mason_lsp.setup_handlers({
  function(server_name)
    lsp[server_name].setup({})
  end,
})
lsp.html.setup({
  filetypes = { "html", "htmlangular" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
  }
})
-- Configuración de autocompletado
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
