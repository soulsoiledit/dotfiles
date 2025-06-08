---@type vim.lsp.Config
return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { ".git", "flake.nix" },
  settings = {
    nixd = {
      options = {
        home = {
          expr = string.format('(builtins.getFlake "%s").homeConfigurations.%s.options', FLAKE, USER)
        },
      },
      formatting = { command = { "nixfmt" } },
    },
  },
}
