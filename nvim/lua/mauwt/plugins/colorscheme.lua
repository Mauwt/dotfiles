--[[ return {
	"folke/tokyonight.nvim",
	priority = 1000, -- make sure to load this before all the other puglins
	config = function()
		-- load the colorscheme here
		vim.cmd([[colorscheme tokyonight-night)
	end,
}--]]

return {

	--"projekt0n/github-nvim-theme",
	--"nyoom-engineering/oxocarbon.nvim",
	"catppuccin/nvim",
	name = "catppuccin",
	dependencies = {
		--    "nvim-lualine/lualine.nvim",
		--	"nvim-tree/nvim-web-devicons",
	},
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		--require("lualine").setup()
		require("catppuccin").setup({
			flavour = "mocha",
			--flavour = "latte",
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				--[[notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				}--]]
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})

		-- setup must be called before loading
		-- vim.opt.background = "dark" -- set this to dark or light
		--vim.cmd("colorscheme github_dark_colorblind")
		vim.cmd("colorscheme catppuccin")
	end,
}
