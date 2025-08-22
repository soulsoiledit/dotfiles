---@type vim.lsp.Config
return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { ".git", "flake.nix" },
  settings = {
    nixd = {
      options = {
        home = {
          expr = vim.fn.expand("(builtins.getFlake (builtins.toString ./.)).homeConfigurations.$USER.options"),
        },
      },
      formatting = { command = { "nixfmt" } },
    },
  },
}
