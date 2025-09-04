local null_ls = require("null-ls")  -- Importar none-ls

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,  -- Formateador Black
        null_ls.builtins.diagnostics.flake8, -- Opcional: linter
    },
})
