vim.loader.enable()

FLAKE = os.getenv("FLAKE")

require("option")
require("keymap")
require("lsp")
require("lz.n").load("plugins")
