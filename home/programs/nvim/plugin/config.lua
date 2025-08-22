local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.confirm = true
opt.timeoutlen = 250

-- indent with 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.shiftround = true

opt.wrap = true

opt.scrolloff = 4
opt.sidescrolloff = 8

-- use indentation for folding and open all folds initially
opt.foldmethod = "indent"
opt.foldlevelstart = 99

vim.g.markdown_recommended_style = false
vim.g.python_recommended_style = false
