vim.loader.enable()

nixpalette = require("nixpalette")

MiniDeps = require("mini.deps")
MiniDeps.setup()
now, later = MiniDeps.now, MiniDeps.later
now_if_args = vim.fn.argc(-1) > 0 and now or later
