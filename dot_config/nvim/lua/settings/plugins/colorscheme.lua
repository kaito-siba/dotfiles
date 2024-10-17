-- kanagawa.nvim configuration

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	config = function()
-- 		local kanagawa = require("kanagawa")
-- 		kanagawa.setup({
-- 			transparent = true,
-- 			overrides = function(colors)
-- 				local theme = colors.theme
-- 				return {
-- 					NormalFloat = { bg = "none" },
-- 					FloatBorder = { bg = "none" },
-- 					FloatTitle = { bg = "none" },

-- 					TelescopeTitle = { fg = theme.ui.special, bold = true },
-- 					TelescopePromptNormal = { bg = "none" },
-- 					TelescopePromptBorder = { bg = "none" },
-- 					TelescopeResultsNormal = { bg = "none" },
-- 					TelescopeResultsBorder = { bg = "none" },
-- 					TelescopePreviewNormal = { bg = "none" },
-- 					TelescopePreviewBorder = { bg = "none" },

-- 					-- Assign a static color to strings
-- 					String = { fg = colors.palette.carpYellow },
-- 				}
-- 			end,
-- 		})

-- 		kanagawa.load("dragon")
-- 	end,
-- }

-- rose-pine configuration

-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		require("rose-pine").setup({
-- 			variant = "moon",
-- 			styles = {
-- 				transparency = true,
-- 			},
-- 		})

-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }
--
-- catppuccin configuration
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "latte",
			transparent_background = true,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
