return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
				},
				follow_current_file = { enabled = true },
			},
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_image_nvim = true } },
				},
			},
		})

		vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "g,", "<Cmd>Neotree git_status<CR>", { noremap = true, silent = true })
	end,
}
