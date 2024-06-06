vim.g.mapleader = " "

-- for conciseness
local keymap = vim.keymap
local silent = { silent = true }

-- normal mode
keymap.set("n", "tn", "<C-w>T")
keymap.set("n", "tl", ":tabn<CR>", silent)
keymap.set("n", "th", ":tabp<CR>", silent)

-- insert mode
keymap.set("i", "jj", "<ESC>")
keymap.set("i", "jk", "<ESC>")
