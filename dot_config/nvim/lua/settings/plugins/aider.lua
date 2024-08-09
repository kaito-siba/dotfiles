return {
	"joshuavial/aider.nvim",
	config = function()
		local aider = require("aider")

		aider.setup({
			auto_message_context = true,
			default_bindiings = true,
		})
		-- set a keybinding for the AiderOpen function
		vim.api.nvim_set_keymap(
			"n",
			"<leader>oa",
			"<cmd>lua AiderOpen('--model gemini/gemini-1.5-flash-latest')<cr>",
			{ noremap = true, silent = true }
		)
		-- set a keybinding for the AiderBackground function
		vim.api.nvim_set_keymap("n", "<leader>ob", "<cmd>lua AiderBackground()<cr>", { noremap = true, silent = true })
	end,
	keys = {
		{
			"<leader>oa",
			function()
				require("aider").AiderOpen("--model gemini/gemini-1.5-flash-latest")
			end,
			desc = "Open Aider with a specific model",
		},
		{
			"<leader>ob",
			function()
				require("aider").AiderBackground("--model gemini/gemini-1.5-flash-latest")
			end,
			desc = "Open Aider in the background",
		},
	},
}
