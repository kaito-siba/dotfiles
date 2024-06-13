return {
	"rebelot/kanagawa.nvim",
	config = function()
		local kanagawa = require("kanagawa")
		kanagawa.setup({
			transparent = true,
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = "none" },
					TelescopePromptBorder = { bg = "none" },
					TelescopeResultsNormal = { bg = "none" },
					TelescopeResultsBorder = { bg = "none" },
					TelescopePreviewNormal = { bg = "none" },
					TelescopePreviewBorder = { bg = "none" },
				}
			end,
		})

		kanagawa.load("wave")
	end,
}
