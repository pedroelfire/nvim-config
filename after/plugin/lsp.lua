---@diagnostic disable-next-line: undefined-global
local vim = vim
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local null_ls = require("null-ls")

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
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
	},
})

local function find_project_library_path()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return nil
	end

	local root_dir = vim.fs.root(current_file, function(name, path)
		if name == "angular.json" or name == ".angular" then
			return true
		end

		if vim.fn.isdirectory(path .. "/node_modules/@angular") == 1 then
			return true
		end

		return false
	end)

	if not root_dir then
		return nil
	end

	local lib_path = root_dir .. "/node_modules/@angular/language-service"

	if vim.fn.isdirectory(lib_path) ~= 1 then
		lib_path = root_dir .. "/node_modules"
	end

	return lib_path
end

local project_library_path = find_project_library_path()

if project_library_path then
	local cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		project_library_path,
		"--ngProbeLocations",
		project_library_path,
	}

	vim.lsp.config("angularls", {
		cmd = cmd,
	})
else
	vim.notify("Angular project not found. AngularLS disabled.", vim.log.levels.WARN)
end

vim.lsp.enable("angularls")

vim.lsp.config("gopls", {
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

vim.lsp.enable("gopls")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.enable("lua_ls")

vim.lsp.config("pyright", {})

vim.lsp.enable("pyright")

vim.lsp.config("html", {})

vim.lsp.enable("html")

vim.lsp.config("cssls", {})

vim.lsp.enable("cssls")

vim.lsp.config("tailwindcss", {})

vim.lsp.enable("tailwindcss")

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
					return format_client.name == "null-ls"
				end,
			})
		end, opts)
	end,
})
