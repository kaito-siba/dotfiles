return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-project.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/trouble.nvim",
		"folke/todo-comments.nvim",
		"CopilotC-Nvim/CopilotChat.nvim",
		"mollerhoj/telescope-recent-files.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local project_actions = require("telescope._extensions.project.actions")

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.providers.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		function DisplayActionPrompts()
			local copilot_actions = require("CopilotChat.actions")
			require("CopilotChat.integrations.telescope").pick(copilot_actions.prompt_actions())
		end

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-o>"] = actions.select_default,
						["<C-s>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.close,
					},
					n = {
						["o"] = actions.select_default,
						["s"] = actions.select_vertical,
						["t"] = actions.select_tab,
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				project = {
					base_dirs = {
						-- "~/src",
						-- "~/proj",
						"~/.config",
						-- "~/dotfiles",
					},
					hidden_files = true,
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
					sync_with_nvim_tree = true,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})

		-- telescope.load_extension("fzf")
		telescope.load_extension("project")
		telescope.load_extension("recent-files")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true })
		keymap.set("n", "<leader>ff", function()
			require("telescope").extensions["recent-files"].recent_files({})
		end, { silent = true })
		keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true })
		keymap.set("n", "<leader>fp", "<cmd>Telescope project<CR>", { silent = true })
		keymap.set("n", "/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { silent = true })
		keymap.set({ "n", "v" }, "<leader>fc", "<cmd>lua DisplayActionPrompts()<CR>", { noremap = true, silent = true })
	end,
}
