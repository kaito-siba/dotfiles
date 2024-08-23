local opt = vim.opt -- for conciseness

opt.foldenable = true
opt.foldcolumn = "0"
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99

-- line numnbers
opt.number = true
opt.relativenumber = true

opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("=")

opt.conceallevel = 1

-- scroll
opt.scrolloff = 10

-- disable swap file
opt.swapfile = false
