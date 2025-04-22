---@type vim.lsp.Config
return {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { ".git", "flake.nix" },
  init_options = {
    nix = { flake = { autoArchive = false } },
  }
}
