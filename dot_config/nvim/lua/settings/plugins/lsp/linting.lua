return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		local phpcs = require("lint").linters.phpcs

		phpcs.args = {
			"-q",
			-- <- Add a new parameter here
			"--standard=PSR12",
			"--report=json",
			"-",
		}

		if vim.fn.filereadable("deno.json") == 1 then
			lint.linters.javaScript = { "deno" }
			lint.linters.typeScript = { "deno" }
		else
			lint.linters.javaScript = { "eslint_d" }
			lint.linters.typeScript = { "eslint_d" }
		end

		lint.linters_by_ft = {
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			php = { "phpcs" },
		}

		lint.linters.pylint.cmd = "python"
		lint.linters.pylint.args = { "-m", "pylint", "--output-format", "json", "-" }

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
