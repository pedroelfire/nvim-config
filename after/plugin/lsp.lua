local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.code_action, { noremap = true, silent = true })

  -- Mapear un comando para formatear manualmente
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end)

lsp.ensure_installed({
    'eslint',
    'angularls',
    'ts_ls',
    'html',
    'ast_grep'
})

local cmp = require('cmp')
cmp.setup({
    mapping = {
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    },
})

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({select=true}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
})

lsp.setup()
