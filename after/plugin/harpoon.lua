local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Configuración de Harpoon con ventana más grande
require("harpoon").setup({
  menu = {
    width = 120, -- Aumentado para ver más parte del nombre/ruta
  }
})

-- Keymaps
vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Agregar archivo a Harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Menú Harpoon" })

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Ir archivo 1 Harpoon" })
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Ir archivo 2 Harpoon" })
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Ir archivo 3 Harpoon" })
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Ir archivo 4 Harpoon" })

vim.keymap.set("n", "<leader>hm", function()
  ui.toggle_quick_menu()
end, { desc = "Harpoon menu" })

