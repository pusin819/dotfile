require("settings")

if vim.g.vscode == 1 then
	-- VS Code用の設定
	-- あればここに書く
	return
end

require("plugins")
require("maps")

vim.cmd([[colorscheme tokyonight]])
