function ColorMyPencils(color, background)
	color = color or "gruvbox-material"
	background = background or "none" -- Por defecto transparente

	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = background })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = background })
end
ColorMyPencils()
