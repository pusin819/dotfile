local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	{
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		config = function()
			require("configs.lualine")
		end,
		dependencies = { "nvim-web-devicons" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("configs.treesitter")
		end,
	},
	{ "windwp/nvim-ts-autotag" },
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.4",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lsp")
		end,
	},
	"onsails/lspkind-nvim",
	{
		"l3mon4d3/luasnip",
		-- follow latest release.
		version = "v<currentmajor>.*",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "insertenter",
		config = function()
			require("configs.cmp")
		end,
	},
	"hrsh7th/cmp-nvim-lsp",
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("configs.null-ls")
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("configs.mason-lsp")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"muniftanjim/nui.nvim",
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("configs.toggleterm")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("configs.autopairs")
		end,
	},
	{
		"xiyaowong/nvim-transparent",
		config = function()
			require("configs.transparent")
		end,
	},
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		-- uncomment next line if you want to follow only stable versions
		-- tag = "*"
	},
	"rust-lang/rust.vim",
	"romgrk/barbar.nvim",
	{
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup()
		end,
	},
	"lervag/vimtex",
	"andweeb/presence.nvim",
	{
		"github/copilot.vim",
		lazy = false,
		config = function()
			vim.g.copilot_no_tab_map = true

			local keymap = vim.keymap.set
			-- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
			keymap(
				"i",
				"<m-u>",
				'copilot#Accept("<CR>")',
				{ silent = true, expr = true, script = true, replace_keycodes = false }
			)
			keymap("i", "<m-.>", "<plug>(copilot-next)")
			keymap("i", "<m-,>", "<plug>(copilot-previous)")
		end,
	},
	{
		"alexvzyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("configs.nordic")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("configs.tokyonight")
		end,
		opts = {},
	},
  {
    "kaarmu/typst.vim",
    ft = 'typst',
    lazy=false,
  },
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "0.3.*",
		build = function()
			require("typst-preview").update()
		end,
	},
}

require("lazy").setup(plugins, opts)
