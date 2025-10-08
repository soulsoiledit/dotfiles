local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.confirm = true
opt.timeoutlen = 250

-- indent with 2 spaces
opt.expandtab = true
opt.shiftwidth = 2
opt.shiftround = true

opt.wrap = true
opt.scrolloff = 4
opt.sidescrolloff = 8

-- use indentation for folding
opt.foldmethod = "indent"
-- open all folds at the start
opt.foldlevelstart = 99
