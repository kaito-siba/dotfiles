return {
	"terrortylor/nvim-comment",
	config = function()
		require("nvim_comment").setup({
			comment_empty = false,
			create_mappings = true,
			line_mapping = "<leader>c",
			operator_mapping = "<leader>c",
			hook = function()
				if vim.api.nvim_buf_get_option(0, "filetype") == "lua" then
					vim.api.nvim_buf_set_option(0, "commentstring", "-- %s")
				end
			end,
		})
	end,
}
