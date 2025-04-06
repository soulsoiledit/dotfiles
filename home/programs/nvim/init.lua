vim.loader.enable()

-- source nix generated config
vim.cmd("source ~/.config/generated/nvim.lua")

require("option")
require("keymap")
require("lsp")
require("lz.n").load("plugins")
