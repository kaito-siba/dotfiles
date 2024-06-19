return {
	"sentriz/vim-print-debug",
	config = function()
		vim.keymap.set("n", "<leader>p", "<Cmd>call print_debug#print_debug()<CR>", { noremap = true, silent = true })

		-- テンプレートが見つからなかった場合のデフォルト設定
		vim.g.print_debug_default = '"{}"'

		-- 各ファイルタイプに対するデバッグラインテンプレートの設定
		vim.g.print_debug_templates = {
			go = 'fmt.Printf("+++ {}\n")',
			python = 'print(f"+++ {}")',
			javascript = "console.log('+++ {}');",
			typescript = "console.log('+++ {}');",
			javascriptreact = "console.log('+++ {}');",
			typescriptreact = "console.log('+++ {}');",
			c = 'printf("+++ {}\n");',
			php = 'echo "+++ " . PHP_EOL;',
			lua = 'print("+++ ");',
		}
	end,
}
