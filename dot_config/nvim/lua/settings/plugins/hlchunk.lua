return {
	"shellRaining/hlchunk.nvim",
	enabled = true,
	branch = "main",
	event = { "UIEnter" },
	config = function()
		require("hlchunk").setup({
			indent = {
				enable = true,
				chars = {
					"│",
					"¦",
					"┆",
					"┊",
				},
				style = {
					vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
				},
			},
			blank = {
				enable = false,
			},
			chunk = {
				enable = true,
				use_treesitter = true,
				chunk = {
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
					style = {
						"#FF0000",
						"#FF7F00",
						"#FFFF00",
						"#00FF00",
						"#00FFFF",
						"#0000FF",
						"#8B00FF",
					},
				},
			},
			line_num = {
				enable = true,
			},
		})
	end,
}
