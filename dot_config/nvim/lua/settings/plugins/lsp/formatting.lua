return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"rcarriga/nvim-notify",
	},
	config = function()
		local conform = require("conform")
		local notify = require("notify")

		conform.formatters.deno = {
			command = "deno_fmt",
			condition = function()
				return vim.fn.filereadable("deno.json") == 1
			end,
		}

		conform.setup({
			formatters_by_ft = {
				javascript = { { "deno_fmt", "prettier" } },
				typescript = { { "deno_fmt", "prettier" } },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				php = { "php-cs-fixer" },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
			formatters = {
				php = {
					command = "php-cs-fixer",
					args = {
						"fix",
						"$FILENAME",
					},
					stdin = false,
				},
			},
			notify_on_error = true,
			log_level = vim.log.levels.INFO,
		})

		vim.keymap.set({ "n", "v" }, "<leader>i", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		local function show_notification(message, level)
			notify(message, level, { title = "conform.nvim" })
		end

		vim.api.nvim_create_user_command("FormatToggle", function(args)
			local is_global = not args.bang
			if is_global then
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				if vim.g.disable_autoformat then
					show_notification("Autoformat-on-save disabled globally", "info")
				else
					show_notification("Autoformat-on-save enabled globally", "info")
				end
			else
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				if vim.b.disable_autoformat then
					show_notification("Autoformat-on-save disabled for this buffer", "info")
				else
					show_notification("Autoformat-on-save enabled for this buffer", "info")
				end
			end
		end, {
			desc = "Toggle autoformat-on-save",
			bang = true,
		})
	end,
}
