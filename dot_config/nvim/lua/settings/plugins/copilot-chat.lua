return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		config = function()
			local select = require("CopilotChat.select")
			require("CopilotChat").setup({
				prompts = {
					Explain = {
						prompt = "/COPILOT_EXPLAIN カーソル上のコードの説明を段落をつけて書いてください。",
					},
					Tests = {
						prompt = "/COPILOT_TESTS カーソル上のコードの詳細な単体テスト関数を書いてください。",
					},
					Fix = {
						prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
					},
					Optimize = {
						prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
					},
					Docs = {
						prompt = "/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
					},
					FixDiagnostic = {
						prompt = "ファイル内の次のような診断上の問題を解決してください：",
						selection = select.diagnostics,
					},
					Commit = {
						prompt = "コミットメッセージをcommitizenの規約に従って書いてください。タイトルは最大50文字とし、メッセージは72文字で改行してください。メッセージ全体を言語指定`gitcommit`のコードブロックで囲んでください。",
						selection = select.gitdiff,
					},
					CommitStaged = {
						prompt = "変更内容のコミットメッセージをcommitizenの規約に従って書いてください。タイトルは最大50文字とし、メッセージは72文字で改行してください。メッセージ全体を言語指定`gitcommit`のコードブロックで囲んでください。",
						selection = function(source)
							return select.gitdiff(source, true)
						end,
					},
					Review = {
						prompt = "/COPILOT_REVIEW 選択したコードをレビューしてください。",
						callback = function(response, source)
							local ns = vim.api.nvim_create_namespace("copilot_review")
							local diagnostics = {}
							for line in response:gmatch("[^\r\n]+") do
								if line:find("^line=") then
									local start_line = nil
									local end_line = nil
									local message = nil
									local single_match, message_match = line:match("^line=(%d+): (.*)$")
									if not single_match then
										local start_match, end_match, m_message_match =
											line:match("^line=(%d+)-(%d+): (.*)$")
										if start_match and end_match then
											start_line = tonumber(start_match)
											end_line = tonumber(end_match)
											message = m_message_match
										end
									else
										start_line = tonumber(single_match)
										end_line = start_line
										message = message_match
									end

									if start_line and end_line then
										table.insert(diagnostics, {
											lnum = start_line - 1,
											end_lnum = end_line - 1,
											col = 0,
											message = message,
											severity = vim.diagnostic.severity.WARN,
											source = "Copilot Review",
										})
									end
								end
							end
							vim.diagnostic.set(ns, source.bufnr, diagnostics)
						end,
					},
				},
			})

			-- バッファの内容全体を使って Copilot とチャットする
			function CopilotChatBuffer()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end

			-- <leader>ccq (Copilot Chat Quick) で Copilot とチャットする
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ccq",
				"<cmd>lua CopilotChatBuffer()<cr>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
