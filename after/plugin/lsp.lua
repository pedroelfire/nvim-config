-- Configuración LSP para Neovim 0.11
local lsp = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local null_ls = require("null-ls")

local function is_angular_project(root_dir)
  return vim.fn.filereadable(root_dir .. "/angular.json") == 1
end


-- Configurar Mason
mason.setup()
mason_lsp.setup({
  ensure_installed = {
    "eslint",
    "html",
    "astro",
    "ast_grep",
  },
})

null_ls.setup({
  sources = {
    -- Agrega aquí los formateadores que necesites
    null_ls.builtins.formatting.prettier, -- Para JavaScript/TypeScript, HTML, CSS, etc.
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black,    -- Para Lua
    -- Puedes agregar más formateadores según tus necesidades
  },
})

lsp.angularls.setup({
  cmd = {
    "ngserver",
    "--stdio",
    "--angularCoreVersion", "19.0.0",
  },
  root_dir = lsp.util.root_pattern("angular.json", "project.json"),
  single_file_support = false,
})

-- Go
lsp.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      ["ui.inlayhint.hints"] = {
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
      },
    },
  },
})

-- Lua
lsp.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      telemetry = { enable = false },
    },
  },
})

-- Python
lsp.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Rust
lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- HTML / CSS / Tailwind
lsp.html.setup({ on_attach = on_attach, capabilities = capabilities })
lsp.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
lsp.tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })
-- Configuración de autocompletado
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(format_client)
          -- Solo usar null-ls para formatear
          return format_client.name == "null-ls"
        end,
      })
    end, opts)
  end,
})
