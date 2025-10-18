local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")

-- Configuración de Telescope
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<Esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				preview_width = 0.6,
				width = 0.9,
				height = 0.9,
			},
		},
		path_display = { "truncate" }, -- Truncar paths largos
		file_ignore_patterns = {
			"node_modules",
			".git",
			"dist",
			"build",
			"target",
			"%.o",
			"%.a",
		},
		sorting_strategy = "ascending",
		winblend = 10,
		border = true,
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" },
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false,
			hidden = true,
		},
		git_files = {
			theme = "dropdown",
			previewer = false,
		},
		live_grep = {
			theme = "dropdown",
			only_sort_text = true,
		},
		buffers = {
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer,
				},
			},
		},
		diagnostics = {
			theme = "dropdown",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

-- Cargar extensión fzf si está disponible
pcall(require("telescope").load_extension, "fzf")

-- Keymaps mejoradas con descripciones
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[P]roject [S]earch" })
vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "[P]roject [G]rep" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "[P]roject [B]uffers" })
vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "[P]roject [H]elp" })
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "[P]roject [D]iagnostics" })
vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "[P]roject [K]eymaps" })

-- Ver error actual
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Ver error actual" })
