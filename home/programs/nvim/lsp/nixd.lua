---@type vim.lsp.Config
return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { ".git", "flake.nix" },
  settings = {
    nixd = {
      options = {
        home = {
          expr =
              '(builtins.getFlake "' .. FLAKE .. '").homeConfigurations.soil.options',
        },
      },
      formatting = { command = { "nixfmt" } },
    },
  },
}
