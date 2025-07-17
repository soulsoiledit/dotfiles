-- source nix generated config
vim.cmd("source ~/.config/generated/nvim.lua")

require("option")
require("keymap")
require("lsp")
vim.loader.enable()

require("lz.n").load("plugins")
