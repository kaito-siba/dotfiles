return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local my_theme = require("lualine.themes.seoul256")

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				disabled_filetypes = { "NvimTree" },
				-- theme = my_theme,
				theme = "auto",
			},
			sections = {
				lualine_c = {},
				lualine_z = {
					{
						"datetime",
						style = "%H:%M",
					},
				},
			},
		})
	end,
}
