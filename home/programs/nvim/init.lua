vim.loader.enable()

nix = require("nixconfig")

misc = require("mini.misc")
safely = misc.safely

function safely_if_args(when1, when2, f)
  return vim.fn.argc(-1) > 0 and safely(when1, f) or safely(when2, f)
end
