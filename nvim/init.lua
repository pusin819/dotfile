require("settings")
require("plugins")
require("maps")

require("monokai-pro").setup({
	transparent_background = true,
	terminal_colors = true,
	filter = "ristretto",
})

vim.cmd([[colorscheme monokai-pro]])
